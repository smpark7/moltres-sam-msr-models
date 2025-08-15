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


def main(mesh_base_file='mesh_base.i', mesh_file='mesh.i', num_nodes=21):
    # Read base mesh file
    root = pyhit.load(mesh_base_file)

    # Extrude 3D
    extrude = moosetree.find(
        root, func=lambda n: n.fullpath == '/Mesh/extrude')
    extrude['heights'] = f"'{core_height}'"
    extrude['num_layers'] = 5
#    mesh_num = int(np.ceil(core_height / axial_mesh_size))
#    extrude['num_layers'] = f"'{mesh_num}'"
#    extrude['heights'] = f"'{thimble_tip_position} {thimble_length}'"
#    lower_mesh_num = int(np.ceil(thimble_tip_position / axial_mesh_size))
#    upper_mesh_num = int(np.ceil(thimble_length / axial_mesh_size))
#    extrude['num_layers'] = \
#        f"'{lower_mesh_num} {upper_mesh_num}'"

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
    curr_name = 'control_channel_bound_4'
    channel_id = 0
    for i in range(row_length):
        for j in range(row_length):
            if channel_grid[i, j] == 1:
                prev_name, curr_name = curr_name, 'channel_bound' + \
                    str(channel_id)
                mesh.append(curr_name)
                node = moosetree.find(
                    root, func=lambda n: n.fullpath == '/Mesh/' + curr_name)
                node['type'] = 'SideSetsFromBoundingBoxGenerator'
                node['input'] = prev_name
                node['boundary_new'] = 10000 + channel_id
                node['bottom_left'] = f"'{x[j]} {x[i]} {lower_plenum_height}'"
                node['top_right'] = \
                    f"'{x[j+1]} {x[i+1]} {lower_plenum_height + core_height}'"
                node['included_boundaries'] = '101'
                channel_id += 1

    pyhit.write(mesh_file, root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
    elif len(argv) == 2:
        main(num_nodes=argv[1])
    elif len(argv) == 4:
        main(mesh_base_file=argv[1], mesh_file=argv[2], num_nodes=argv[3])
