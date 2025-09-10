#!/usr/bin/env python
"""
setup.py
--------
This module contains the function to build the SAM mesh file for TH_2.

Functions:
    - main
"""
import pyhit
import moosetree
import numpy as np
from sys import argv

# Base geometry specifications
# Replace with imports once msr_progression_problem_tools.py is refactored
core_height = 170.027e-2  # m
lower_plenum_height = 0.1875
stringer_pitch = 5.08e-2  # m
fuel_channel_r = 0.508e-2  # m
fuel_channel_a = 2.032e-2  # m
thimble_tip_position = 6.35e-2  # m
thimble_length = core_height - thimble_tip_position
temperature = 900
CHANNEL_VOL_FLOW_RATE = 6.31e-5  # m3/s
CORE_OUTLET_PRESSURE = 149616.2  # Pa (absolute)
DENSITY = 2.3275e3  # kg/m3
inch = 2.54e-2
pitch = np.sqrt(2) * inch
axial_mesh_size = 5e-2


def main(mesh_base_file='nt_mesh_quad_base.i',
         mesh_file='nt_mesh_quad.i'):
    # Read base mesh file
    root = pyhit.load(mesh_base_file)

    # Grid data
    nx = 11
    x = np.linspace(-5 * pitch, 5 * pitch, nx)
    center_idx = [(nx-1)//2-1, (nx-1)//2]

    # Extrude 3D
    extrude = moosetree.find(
        root, func=lambda n: n.fullpath == '/Mesh/extrude')
    extrude['heights'] = f"'{core_height}'"
    extrude['num_layers'] = 34
#    mesh_num = int(np.ceil(core_height / axial_mesh_size))
#    extrude['num_layers'] = f"'{mesh_num}'"
#    extrude['heights'] = f"'{thimble_tip_position} {thimble_length}'"
#    lower_mesh_num = int(np.ceil(thimble_tip_position / axial_mesh_size))
#    upper_mesh_num = int(np.ceil(thimble_length / axial_mesh_size))
#    extrude['num_layers'] = \
#        f"'{lower_mesh_num} {upper_mesh_num}'"

    # Label channel boundary IDs
    mesh = moosetree.find(
        root, func=lambda n: n.fullpath == '/Mesh')
    curr_name = 'cleanup'
    for i in range(nx-1):
        for j in range(nx-1):
            if i == center_idx[0] and j == center_idx[0]:
                top_right = \
                    f"'{x[j+2]} {x[i+2]} {core_height+lower_plenum_height}'"
            elif i in center_idx and j in center_idx:
                continue
            else:
                top_right = \
                    f"'{x[j+1]} {x[i+1]} {core_height+lower_plenum_height}'"
            prev_name, curr_name = curr_name, 'channel_bound' + str(i) + str(j)
            mesh.append(curr_name)
            node = moosetree.find(
                root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
            node['type'] = 'SideSetsFromBoundingBoxGenerator'
            node['input'] = prev_name
            node['boundary_new'] = 200 + i * 10 + j
            node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
            node['top_right'] = top_right
            node['included_boundaries'] = '100'

    # Label channel block IDs
    for i in range(nx-1):
        for j in range(nx-1):
            if i in center_idx and j in center_idx:
                continue
            top_right = \
                f"'{x[j+1]} {x[i+1]} {core_height+lower_plenum_height}'"
            prev_name, curr_name = curr_name, 'channel_block_2' + str(i) + str(j)
            mesh.append(curr_name)
            node = moosetree.find(
                root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
            node['type'] = 'SubdomainBoundingBoxGenerator'
            node['input'] = prev_name
            node['block_id'] = 200 + i * 10 + j
            node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
            node['top_right'] = top_right
            node['restricted_subdomains'] = '10'
            prev_name, curr_name = curr_name, 'channel_block_3' + str(i) + str(j)
            mesh.append(curr_name)
            node = moosetree.find(
                root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
            node['type'] = 'SubdomainBoundingBoxGenerator'
            node['input'] = prev_name
            node['block_id'] = 300 + i * 10 + j
            node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
            node['top_right'] = top_right
            node['restricted_subdomains'] = '11'

    top_right = \
        f"'{x[center_idx[0]+2]} {x[center_idx[0]+2]} {core_height+lower_plenum_height}'"
    prev_name, curr_name = curr_name, 'channel_block_244'
    mesh.append(curr_name)
    node = moosetree.find(
        root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
    node['type'] = 'SubdomainBoundingBoxGenerator'
    node['input'] = prev_name
    node['block_id'] = 244
    node['bottom_left'] = f"'{x[center_idx[0]]} {x[center_idx[0]]} {lower_plenum_height}'"
    node['top_right'] = top_right
    node['restricted_subdomains'] = '15'

    pyhit.write(mesh_file, root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
    elif len(argv) == 3:
        main(mesh_base_file=argv[1], mesh_file=argv[2])
