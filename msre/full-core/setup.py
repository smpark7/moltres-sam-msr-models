#!/usr/bin/env python
"""
setup.py
--------
This module contains the function to build the SAM input file for TH_2_1_A.

Functions:
    - main
"""
import pyhit
import moosetree
import numpy as np
from math import pi
from sys import argv

# Base geometry specifications
# Replace with imports once msr_progression_problem_tools.py is refactored
core_height = 170.027e-2  # m
stringer_pitch = 5.08e-2  # m
fuel_channel_r = 0.508e-2  # m
fuel_channel_a = 2.032e-2  # m
cr_thimble_tip_position = 6.405e-2  # m
lower_plenum_height = 0.1875
upper_plenum_height = 0.2540
temperature = 900
inch = 2.54e-2
pitch = np.sqrt(2) * inch
total_width = pitch * 10
control_channel_inner_r = inch
control_channel_outer_r = 3.1992e-2
CHANNEL_VOL_FLOW_RATE = 6.31e-5  # m3/s
TOTAL_VOL_FLOW_RATE = CHANNEL_VOL_FLOW_RATE * 1200
CORE_OUTLET_PRESSURE = 149616.2  # Pa (absolute)
DENSITY = 2.3275e3  # kg/m3

# Graphite properties
graphite_k = 154.797
graphite_cp = 1758.46
graphite_rho = 1860


def main(input_base_file='input_base.i', input_file='input.i',
         sub_base_file='input_sub_base.i', sub_file='input_sub.i'):

    # Hydraulic diameter and flow area
    stadium_circle_area = pi * fuel_channel_r ** 2
    stadium_rectangle_area = fuel_channel_a * (2 * fuel_channel_r)
    flow_area = stadium_circle_area + stadium_rectangle_area
    wetted_perimeter = (2 * pi * fuel_channel_r) + 2 * fuel_channel_a
    hydraulic_diameter = (4 * flow_area) / wetted_perimeter

    control_channel_Dh = \
        (control_channel_outer_r - control_channel_inner_r) * 2
    control_channel_A = \
        pi * (control_channel_outer_r ** 2 - control_channel_inner_r ** 2)
    control_channel_Ph = 2 * pi * control_channel_outer_r

    # Read base input file
    sub_root = pyhit.load(sub_base_file)

    # Shared input parameters among pipe Components
    pipe_input = moosetree.find(
        sub_root,
        func=lambda n: n.fullpath == '/ComponentInputParameters/pipe_input')
    pipe_input['eos'] = 'eos'
    pipe_input['Dh'] = hydraulic_diameter  # m
    pipe_input['A'] = flow_area  # m2
    pipe_input['orientation'] = "'0 0 1'"
    pipe_input['heat_source'] = 'salt_heat_func'
    # Dittus-Boelter (Salt heating) Nu = 0.023 Re^0.8 Pr^0.4
    pipe_input['HTC_user_option'] = 'UserForced'
    pipe_input['User_defined_HTC_parameters'] = "'4.36 0 0 0 0 0 0'"

    control_input = moosetree.find(
        sub_root,
        func=lambda n: n.fullpath == '/ComponentInputParameters/control_input')
    control_input['eos'] = 'eos'
    control_input['Dh'] = control_channel_Dh
    control_input['A'] = control_channel_A
    control_input['Ph'] = control_channel_Ph
    control_input['orientation'] = "'0 0 1'"
    control_input['heat_source'] = 'salt_heat_func'
    control_input['HTC_geometry_type'] = 'Pipe'
    control_input['HTC_user_option'] = 'UserForced'
    control_input['User_defined_HTC_parameters'] = "'4.36 0 0 0 0 0 0'"

    # Inlet Component
    inlet = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Components/inlet')
    inlet['m_bc'] = DENSITY * TOTAL_VOL_FLOW_RATE  # kg/s
    inlet['T_bc'] = temperature

    # Outlet Component
    outlet = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Components/outlet')
    outlet['p_bc'] = CORE_OUTLET_PRESSURE  # Pa

    # Lower plenum
    lower_plenum = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Components/lower_plenum')
    lower_plenum['Dh'] = total_width
    lower_plenum['A'] = total_width ** 2
    lower_plenum['orientation'] = "'0 0 1'"
    lower_plenum['position'] = "'0 0 0'"
    lower_plenum['length'] = lower_plenum_height
    lower_plenum['n_elems'] = 10

    # Upper plenum
    upper_plenum = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Components/upper_plenum')
    upper_plenum['Dh'] = total_width
    upper_plenum['A'] = total_width ** 2
    upper_plenum['orientation'] = "'0 0 1'"
    upper_plenum['position'] = f"'0 0 {lower_plenum_height+core_height}'"
    upper_plenum['length'] = upper_plenum_height
    upper_plenum['n_elems'] = 10

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

    # Create pipe components and UserObjects
    components = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Components')
    pipe_inlets, pipe_outlets = '', ''
    channel_id = 0
    for i in range(row_length):
        for j in range(row_length):
            if channel_grid[i, j] == 1:
                x_pos, y_pos = (x[j+1] + x[j]) / 2, (x[i+1] + x[i]) / 2
                pipe_name = 'pipe_' + str(channel_id)
                pipe_inlets += pipe_name + '(in) '
                pipe_outlets += pipe_name + '(out) '
                components.append(pipe_name)
                pipe = moosetree.find(
                    sub_root,
                    func=lambda n: n.fullpath == '/Components/' + pipe_name)
                pipe['type'] = 'PBOneDFluidComponent'
                pipe['input_parameters'] = 'pipe_input'
                pipe['position'] = f"'{x_pos} {y_pos} {lower_plenum_height}'"
                pipe['length'] = core_height
                pipe['n_elems'] = 68

                heat_transfer_name = 'heat_flux_' + str(channel_id)
                components.append(heat_transfer_name)
                heat_transfer = moosetree.find(
                    sub_root,
                    func=lambda n: n.fullpath ==
                    '/Components/' + heat_transfer_name)
                heat_transfer['type'] = 'HeatTransferWithExternalHeatStructure'
                heat_transfer['T_wall_name'] = 'T_wall'
                heat_transfer['flow_component'] = pipe_name
                heat_transfer['initial_T_wall'] = temperature
                heat_transfer['htc_name'] = 'heat_transfer_coefficient'
                channel_id += 1
    total_channels = channel_id + 1 + 4  # 4 control channels

    # Control channel pipes
    offset = 2 * np.sqrt(2) * inch
    control_channel_pos = [[0, offset],
                           [-offset, 0],
                           [0, -offset],
                           [offset, 0]]
    for i in range(4):
        x_pos, y_pos = control_channel_pos[i][0], control_channel_pos[i][1]
        pipe_name = 'control_' + str(i)
        pipe_inlets += pipe_name + '(in) '
        pipe_outlets += pipe_name + '(out) '
        components.append(pipe_name)
        pipe = moosetree.find(
            sub_root,
            func=lambda n: n.fullpath == '/Components/' + pipe_name)
        pipe['type'] = 'PBOneDFluidComponent'
        pipe['input_parameters'] = 'control_input'
        pipe['position'] = f"'{x_pos} {y_pos} {lower_plenum_height}'"
        pipe['length'] = core_height
        pipe['n_elems'] = 68

        heat_transfer_name = 'control_heat_flux_' + str(i)
        components.append(heat_transfer_name)
        heat_transfer = moosetree.find(
            sub_root,
            func=lambda n: n.fullpath ==
            '/Components/' + heat_transfer_name)
        heat_transfer['type'] = 'HeatTransferWithExternalHeatStructure'
        heat_transfer['T_wall_name'] = 'T_wall'
        heat_transfer['flow_component'] = pipe_name
        heat_transfer['initial_T_wall'] = temperature
        heat_transfer['htc_name'] = 'heat_transfer_coefficient'

    # Lower branch
    lower_branch = moosetree.find(
        sub_root, lambda n: n.fullpath == '/Components/lower_branch')
    lower_branch['K'] = "'" + "0 " * total_channels + "'"
    lower_branch['inputs'] = 'lower_plenum(out)'
    lower_branch['outputs'] = "'" + pipe_inlets + "'"
    lower_branch['Area'] = total_width ** 2

    # Upper branch
    upper_branch = moosetree.find(
        sub_root, lambda n: n.fullpath == '/Components/upper_branch')
    lower_branch['K'] = "'" + "0 " * total_channels + "'"
    upper_branch['inputs'] = "'" + pipe_outlets + "'"
    upper_branch['outputs'] = 'upper_plenum(in)'
    upper_branch['Area'] = total_width ** 2

    # Equation of state definitions
    # TODO: Refactor to use flowforge
    # TODO: Refactor this section so that it can be reused in other SAM input
    # files
    eos = moosetree.find(sub_root, func=lambda n: n.fullpath == '/EOS/eos')
    eos['type'] = 'PTFunctionsEOS'
    eos['cp'] = 2386
    eos['rho'] = 'rho_func'
    eos['k'] = 1.1
    eos['mu'] = 'mu_func'
    eos['T_min'] = 800
    eos['T_max'] = 1200
    eos['T_nodes'] = 51

    # Density function
    rho_func = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Functions/rho_func')
    rho_func.setComment("type",
                        "Density function, rho = 2413 - (0.488 * T) kg/m3")
    def rho_eval(T):
        return 2413 - (0.488 * T)
    rho_x = np.array([800, 1200])
    rho_y = rho_eval(rho_x)
    rho_func['x'] = "'" + str(rho_x)[1:-1].replace(",", "") + "'"
    rho_func['y'] = "'" + str(rho_y)[1:-1].replace(",", "") + "'"

    # Dynamic viscosity function
    mu_func = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Functions/mu_func')
    mu_func.setComment(
        "type", "Dynamic viscosity function, mu = 0.116e-3 * exp(3755 / T)")
    def mu_eval(T):
        return 0.116e-3 * np.exp(3755 / T)
    mu_x = np.arange(800, 1210, 10)
    mu_y = mu_eval(mu_x)
    mu_func['x'] = "'" + str(mu_x)[1:-1].replace(",", "") + "'"
    mu_func['y'] = "'" + str(mu_y)[1:-1].replace(",", "") + "'"

    # Salt heat function
    salt_heat_func = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Functions/salt_heat_func')
    salt_heat_func['expression'] = "'10.162e6 * sin(pi*((x+0.1107)/1.9736))'"

    pyhit.write(sub_file, sub_root)

    # Base file
    root = pyhit.load(input_base_file)

    # BCs
    wall = moosetree.find(
        root, func=lambda n:n.fullpath == '/BCs/wall')
    boundary = [str(int(n))
                for i, n in enumerate(np.linspace(10000, 11135, 1136))] + \
                    ['20000', '20001', '20002', '20003']
    wall['boundary'] = "'" + ' '.join(boundary) + "'"

    # Nearest location transfers
    T_fluid_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/T_fluid_from_sub')
    T_fluid_transfer['to_boundaries'] = "'" + ' '.join(boundary) + "'"
    h_wall_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/h_wall_from_sub')
    h_wall_transfer['to_boundaries'] = "'" + ' '.join(boundary) + "'"

    # Graphite heat function
    graphite_heat_func = moosetree.find(
        root, func=lambda n: n.fullpath == '/Functions/graphite_heat_func')
    graphite_heat_func['expression'] = \
        "'0.7163e6 * cos(1.53 * z - 1.2677) + 0.0127e6'"

    # Graphite material properties
    graphite = moosetree.find(
        root, func=lambda n: n.fullpath == '/Materials/graphite')
    graphite['prop_names'] = "'k cp rho'"
    graphite['prop_values'] = f"'{graphite_k} {graphite_cp} {graphite_rho}'"

    pyhit.write(input_file, root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
#    elif len(argv) == 2:
#        main(num_nodes=argv[1])
#    elif len(argv) == 4:
#        main(input_base_file=argv[1], input_file=argv[2], num_nodes=argv[3])
