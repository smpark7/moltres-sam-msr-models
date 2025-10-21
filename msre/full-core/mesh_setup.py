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
upper_plenum_height = 0.2540
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


def main(mesh_base_file='mesh_coarse_base.i', mesh_file='mesh_coarse.i'):
    # Read base mesh file
    root = pyhit.load(mesh_base_file)

    # Extrude 3D
    extrude = moosetree.find(
        root, func=lambda n: n.fullpath == '/Mesh/extrude')
    extrude['heights'] = \
        f"'{lower_plenum_height} {core_height} {upper_plenum_height}'"
    extrude['num_layers'] = "'4 5 5'"
    extrude['subdomain_swaps'] = \
        "'0 3 1 4 2 3 10 3 11 4 15 3; ; 0 5 1 6 2 5 10 5 11 6 15 5'"

    # Identify channel locations on grid
    channel_rows = [10, 16, 18, 22, 26, 28, 30, 30, 32, 32, 34, 36, 36, 36, 38,
                    38, 38, 38, 38]
    channel_rows = channel_rows + channel_rows[::-1]
    row_length = len(channel_rows)
    channel_grid = np.zeros((row_length, row_length))
    for i in range(row_length):
        start_idx = int((row_length - channel_rows[i]) / 2)
        end_idx = start_idx + channel_rows[i]
        for j in range(row_length):
            if start_idx <= j and j < end_idx:
                channel_grid[i, j] = 1

    # Remove control channels from grid
    channel_grid[row_length//2-1, row_length//2+1] = 0
    channel_grid[row_length//2, row_length//2+1] = 0
    channel_grid[row_length//2, row_length//2+2] = 0
    channel_grid[row_length//2-1, row_length//2+2] = 0
    channel_grid[row_length//2+1, row_length//2-1] = 0
    channel_grid[row_length//2+2, row_length//2-1] = 0
    channel_grid[row_length//2+2, row_length//2] = 0
    channel_grid[row_length//2+1, row_length//2] = 0
    channel_grid[row_length//2-1, row_length//2-3] = 0
    channel_grid[row_length//2, row_length//2-3] = 0
    channel_grid[row_length//2, row_length//2-2] = 0
    channel_grid[row_length//2-1, row_length//2-2] = 0
    channel_grid[row_length//2-3, row_length//2-1] = 0
    channel_grid[row_length//2-2, row_length//2-1] = 0
    channel_grid[row_length//2-2, row_length//2] = 0
    channel_grid[row_length//2-3, row_length//2] = 0

    # Grid data
    x = np.linspace(-row_length / 2 * pitch,
                    row_length / 2 * pitch,
                    row_length + 1)

    # Label channel boundary IDs
    mesh = moosetree.find(
        root, func=lambda n: n.fullpath == '/Mesh')
    curr_name = 'control_channel_block_4'
    channel_id = 0
    for i in range(row_length):
        for j in range(row_length):
            if channel_grid[i, j] == 1:
                prev_name, curr_name = curr_name, 'channel_bound_' + \
                    str(10000+channel_id)
                mesh.append(curr_name)
                node = moosetree.find(
                    root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
                node['type'] = 'SideSetsFromBoundingBoxGenerator'
                node['input'] = prev_name
                node['boundary_new'] = 10000 + channel_id
                node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
                node['top_right'] = \
                    f"'{x[j+1]} {x[i+1]} {lower_plenum_height + core_height}'"
                node['included_boundaries'] = '100'
                channel_id += 1

    # Label channel block IDs
    channel_id = 0
    for i in range(row_length):
        for j in range(row_length):
            if channel_grid[i, j] == 1:
                prev_name, curr_name = curr_name, 'channel_block_' + \
                    str(10000+channel_id)
                mesh.append(curr_name)
                node = moosetree.find(
                    root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
                node['type'] = 'SubdomainBoundingBoxGenerator'
                node['input'] = prev_name
                node['block_id'] = 10000 + channel_id
                node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
                node['top_right'] = \
                    f"'{x[j+1]} {x[i+1]} {lower_plenum_height + core_height}'"
                node['restricted_subdomains'] = '10'
                prev_name, curr_name = curr_name, 'channel_block_' + \
                    str(20000+channel_id)
                mesh.append(curr_name)
                node = moosetree.find(
                    root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
                node['type'] = 'SubdomainBoundingBoxGenerator'
                node['input'] = prev_name
                node['block_id'] = 20000 + channel_id
                node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
                node['top_right'] = \
                    f"'{x[j+1]} {x[i+1]} {lower_plenum_height + core_height}'"
                node['restricted_subdomains'] = '11'
                channel_id += 1

    pyhit.write(mesh_file, root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
    elif len(argv) == 3:
        main(mesh_base_file=argv[1], mesh_file=argv[2])
