#!/usr/bin/env python
"""
setup.py
--------
This module contains the function to build the SAM input file for full-core
MSRE.

Functions:
    - main
"""
import pyhit
import moosetree
import numpy as np
import json
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
plenum_radius = 0.71120
temperature = 908.15
inch = 2.54e-2
pitch = np.sqrt(2) * inch
control_channel_inner_r = inch
control_channel_outer_r = 3.1992e-2
CHANNEL_VOL_FLOW_RATE = 6.31e-5  # m3/s
TOTAL_VOL_FLOW_RATE = CHANNEL_VOL_FLOW_RATE * 1200
CORE_OUTLET_PRESSURE = 149616.2  # Pa (absolute)
DENSITY = 1969.8228 # 2.3275e3  # kg/m3

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
    root = pyhit.load(input_base_file)

    # Read precursor decay constants from group constant json file
    with open('../openmc/xs-data/msre_si.json', 'r') as file:
        xsdata = json.load(file)
    decay_constants = xsdata['fuel']['900']['DECAY_CONSTANT']
    decay_constants_str = \
        "'" + " ".join(map(str, decay_constants)) + "'"
    beta = xsdata['fuel']['900']['BETA_EFF']

    # PBModelParams
    pb_model_params = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/GlobalParams/PBModelParams')
    pb_model_params['passive_scalar'] = "'pre1 pre2 pre3 pre4 pre5 pre6'"
    pb_model_params['passive_scalar_decay_constant'] = decay_constants_str
    pb_model_params['global_init_PS'] = "'0 0 0 0 0 0'"
    pb_model_params['PS_scaling_factor'] = "'1e-0 1e-0 1e-0 1e-0 1e-0 1e-0'"

    # Delayed neutron source auxkernels
    delayed_neutron_aux = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/AuxKernels/delayed_neutron')
    expression = "'("
    for k in range(1, 7):
        # Delayed neutron source contribution from precursor group k
        expression += \
                f"{decay_constants[k-1]} * pre" + str(k)
        if k != 6:
            expression += ' + '
        else:
            expression += ")'"
    delayed_neutron_aux['expression'] = expression

    # Shared input parameters among pipe Components
    pipe_input = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/ComponentInputParameters/pipe_input')
    pipe_input['eos'] = 'eos'
    pipe_input['Dh'] = hydraulic_diameter  # m
    pipe_input['A'] = flow_area  # m2
    pipe_input['orientation'] = "'0 0 1'"
    pipe_input['heat_source_var'] = 'heat'
    ## Dittus-Boelter (Salt heating) Nu = 0.023 Re^0.8 Pr^0.4
    pipe_input['HTC_user_option'] = 'UserForced'
    pipe_input['User_defined_HTC_parameters'] = "'4.36 0 0 0 0 0 0'"

    control_input = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/ComponentInputParameters/control_input')
    control_input['eos'] = 'eos'
    control_input['Dh'] = control_channel_Dh
    control_input['A'] = control_channel_A
    control_input['Ph'] = control_channel_Ph
    control_input['orientation'] = "'0 0 1'"
    control_input['heat_source_var'] = 'heat'
    control_input['HTC_geometry_type'] = 'Pipe'
    control_input['HTC_user_option'] = 'UserForced'
    control_input['User_defined_HTC_parameters'] = "'4.36 0 0 0 0 0 0'"

    # Inlet Component
    inlet = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/inlet')
    inlet['m_bc'] = DENSITY * TOTAL_VOL_FLOW_RATE  # kg/s
    inlet['T_bc'] = temperature

    # Outlet Component
    outlet = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/outlet')
    outlet['p_bc'] = CORE_OUTLET_PRESSURE  # Pa

    # Lower plenum
    lower_plenum = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/lower_plenum')
    lower_plenum['Dh'] = plenum_radius * 2
    lower_plenum['A'] = np.pi * plenum_radius ** 2
    lower_plenum['orientation'] = "'0 0 1'"
    lower_plenum['position'] = "'0 0 0'"
    lower_plenum['length'] = lower_plenum_height
    lower_plenum['n_elems'] = 4 * 2
    lower_plenum['heat_source_var'] = 'heat'

    # Upper plenum
    upper_plenum = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/upper_plenum')
    upper_plenum['Dh'] = plenum_radius * 2
    upper_plenum['A'] = np.pi * plenum_radius ** 2
    upper_plenum['orientation'] = "'0 0 1'"
    upper_plenum['position'] = f"'0 0 {lower_plenum_height+core_height}'"
    upper_plenum['length'] = upper_plenum_height
    upper_plenum['n_elems'] = 5 * 2
    upper_plenum['heat_source_var'] = 'heat'

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
        root, func=lambda n: n.fullpath == '/Components')
    pipe_inlets, pipe_outlets = '', ''
    channel_id = 0
    for i in range(row_length):
        for j in range(row_length):
            if channel_grid[i, j] == 1:
                x_pos, y_pos = (x[j+1] + x[j]) / 2, (x[i+1] + x[i]) / 2
                pipe_name = 'pipe_' + str(10000+channel_id)
                pipe_inlets += pipe_name + '(in) '
                pipe_outlets += pipe_name + '(out) '
                components.append(pipe_name)
                pipe = moosetree.find(
                    root,
                    func=lambda n: n.fullpath == '/Components/' + pipe_name)
                pipe['type'] = 'PBOneDFluidComponent'
                pipe['input_parameters'] = 'pipe_input'
                pipe['position'] = f"'{x_pos} {y_pos} {lower_plenum_height}'"
                pipe['length'] = core_height
                pipe['n_elems'] = 34 * 1

                heat_transfer_name = 'heat_flux_' + str(10000+channel_id)
                components.append(heat_transfer_name)
                heat_transfer = moosetree.find(
                    root,
                    func=lambda n: n.fullpath ==
                    '/Components/' + heat_transfer_name)
                heat_transfer['type'] = 'HeatTransferWithExternalHeatStructure'
                heat_transfer['T_wall_name'] = 'T_wall'
                heat_transfer['flow_component'] = pipe_name
                heat_transfer['initial_T_wall'] = temperature
                heat_transfer['htc_name'] = 'heat_transfer_coefficient'
                channel_id += 1
    total_channels = channel_id + 4  # 4 control channels

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
            root,
            func=lambda n: n.fullpath == '/Components/' + pipe_name)
        pipe['type'] = 'PBOneDFluidComponent'
        pipe['input_parameters'] = 'control_input'
        pipe['position'] = f"'{x_pos} {y_pos} {lower_plenum_height}'"
        pipe['length'] = core_height
        pipe['n_elems'] = 34 * 1

        heat_transfer_name = 'control_heat_flux_' + str(i)
        components.append(heat_transfer_name)
        heat_transfer = moosetree.find(
            root,
            func=lambda n: n.fullpath == '/Components/' + heat_transfer_name)
        heat_transfer['type'] = 'HeatTransferWithExternalHeatStructure'
        heat_transfer['T_wall_name'] = 'T_wall'
        heat_transfer['flow_component'] = pipe_name
        heat_transfer['initial_T_wall'] = temperature
        heat_transfer['htc_name'] = 'heat_transfer_coefficient'

    # Lower branch
    lower_branch = moosetree.find(
        root, lambda n: n.fullpath == '/Components/lower_branch')
    lower_branch['K'] = "'" + "0 " * (total_channels+1) + "'"
    lower_branch['inputs'] = 'lower_plenum(out)'
    lower_branch['outputs'] = "'" + pipe_inlets + "'"
    lower_branch['Area'] = np.pi * plenum_radius ** 2

    # Upper branch
    upper_branch = moosetree.find(
        root, lambda n: n.fullpath == '/Components/upper_branch')
    lower_branch['K'] = "'" + "0 " * (total_channels+1) + "'"
    upper_branch['inputs'] = "'" + pipe_outlets + "'"
    upper_branch['outputs'] = 'upper_plenum(in)'
    upper_branch['Area'] = np.pi * plenum_radius ** 2

    # Equation of state definitions
    # TODO: Refactor to use flowforge
    # TODO: Refactor this section so that it can be reused in other SAM input
    # files
    eos = moosetree.find(root, func=lambda n: n.fullpath == '/EOS/eos')
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
        root, func=lambda n: n.fullpath == '/Functions/rho_func')
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
        root, func=lambda n: n.fullpath == '/Functions/mu_func')
    mu_func.setComment(
        "type", "Dynamic viscosity function, mu = 0.116e-3 * exp(3755 / T)")
    def mu_eval(T):
        return 0.116e-3 * np.exp(3755 / T)
    mu_x = np.arange(800, 1210, 10)
    mu_y = mu_eval(mu_x)
    mu_func['x'] = "'" + str(mu_x)[1:-1].replace(",", "") + "'"
    mu_func['y'] = "'" + str(mu_y)[1:-1].replace(",", "") + "'"

    # Nearest location transfer to_boundaries
    boundary_1 = [str(int(n))
                  for i, n in enumerate(np.linspace(10000,
                                                    10000+total_channels-5,
                                                    total_channels-4))]
    boundary_1 = "'" + ' '.join(boundary_1) + "'"
    T_fluid_boundaries_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/T_fluid_to_sub_boundaries')
    T_fluid_boundaries_transfer['to_boundaries'] = boundary_1
    h_wall_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/h_wall_to_sub')
    h_wall_transfer['to_boundaries'] = boundary_1

    # Sub file
    sub_root = pyhit.load(sub_base_file)

#    # BCs
#    wall = moosetree.find(
#        sub_root, func=lambda n:n.fullpath == '/BCs/wall')
#    boundary_2 = [str(int(n))
#                  for i, n in enumerate(np.linspace(10000,
#                                                    10000+total_channels-5,
#                                                    total_channels-4))
#                  ] + ['30000', '30001', '30002', '30003']
#    wall['boundary'] = "'" + ' '.join(boundary_2) + "'"

    # Graphite material properties
    graphite = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Materials/graphite')
    graphite['prop_names'] = "'k cp rho'"
    graphite['prop_values'] = f"'{graphite_k} {graphite_cp} {graphite_rho}'"

    # UserObjects & Transfers
    uo = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/UserObjects')
    transfers = moosetree.find(
        root, func=lambda n: n.fullpath == '/Transfers')
    kernels = moosetree.find(
        root, func=lambda n: n.fullpath == '/Kernels')
    channel_id = 0
    for i in range(row_length):
        for j in range(row_length):
            if channel_grid[i, j] == 1:
                T_wall_uo_name = 'T_wall_uo_' + str(10000+channel_id)
                uo.append(T_wall_uo_name)
                T_wall_uo = moosetree.find(
                    sub_root,
                    func=lambda n: n.fullpath == '/UserObjects/' + T_wall_uo_name)
                T_wall_uo['type'] = 'LayeredSideAverage'
                T_wall_uo['variable'] = 'T_solid'
                T_wall_uo['direction'] = 'z'
                T_wall_uo['num_layers'] = 170
                T_wall_uo['boundary'] = str(10000+channel_id)
                T_wall_uo['execute_on'] = "'initial timestep_end'"
                T_wall_uo['sample_type'] = 'direct'

                T_wall_transfer_name = 'T_wall_from_sub_' + str(10000+channel_id)
                transfers.append(T_wall_transfer_name)
                T_wall_transfer = moosetree.find(
                    root,
                    func=lambda n: n.fullpath == '/Transfers/' + T_wall_transfer_name)
                T_wall_transfer['type'] = 'MultiAppGeneralFieldUserObjectTransfer'
                T_wall_transfer['from_multi_app'] = 'sub'
                T_wall_transfer['source_user_object'] = T_wall_uo_name
                T_wall_transfer['variable'] = 'T_wall'
                T_wall_transfer['displaced_target_mesh'] = 'true'
                T_wall_transfer['to_blocks'] = 'pipe_' + str(10000+channel_id)
                T_wall_transfer['search_value_conflicts'] = 'false'

                heat_uo_name = 'heat_uo_' + str(10000+channel_id)
                uo.append(heat_uo_name)
                heat_uo = moosetree.find(
                    sub_root,
                    func=lambda n: n.fullpath == '/UserObjects/' + heat_uo_name)
                heat_uo['type'] = 'LayeredAverage'
                heat_uo['variable'] = 'heat'
                heat_uo['direction'] = 'z'
                heat_uo['num_layers'] = 170
                heat_uo['block'] = f"'{10000+channel_id} {20000+channel_id}'"
                heat_uo['execute_on'] = "'initial timestep_end'"
                heat_uo['sample_type'] = 'direct'

                heat_transfer_name = 'heat_from_sub_' + str(10000+channel_id)
                transfers.append(heat_transfer_name)
                heat_transfer = moosetree.find(
                    root,
                    func=lambda n: n.fullpath == '/Transfers/' + heat_transfer_name)
                heat_transfer['type'] = 'MultiAppGeneralFieldUserObjectTransfer'
                heat_transfer['from_multi_app'] = 'sub'
                heat_transfer['source_user_object'] = heat_uo_name
                heat_transfer['variable'] = 'heat'
                heat_transfer['displaced_target_mesh'] = 'true'
                heat_transfer['to_blocks'] = 'pipe_' + str(10000+channel_id)
                heat_transfer['search_value_conflicts'] = 'false'

                nt_source_uo_name = 'neutron_source_uo_' + str(10000+channel_id)
                uo.append(nt_source_uo_name)
                nt_source_uo = moosetree.find(
                    sub_root,
                    func=lambda n: n.fullpath == '/UserObjects/' + nt_source_uo_name)
                nt_source_uo['type'] = 'LayeredAverage'
                nt_source_uo['variable'] = 'neutron_source'
                nt_source_uo['direction'] = 'z'
                nt_source_uo['num_layers'] = 170
                nt_source_uo['block'] = f"'{10000+channel_id} {20000+channel_id}'"
                nt_source_uo['execute_on'] = "'initial timestep_end'"
                nt_source_uo['sample_type'] = 'direct'

                nt_source_transfer_name = 'neutron_source_from_sub_' + str(10000+channel_id)
                transfers.append(nt_source_transfer_name)
                nt_source_transfer = moosetree.find(
                    root,
                    func=lambda n: n.fullpath == '/Transfers/' + nt_source_transfer_name)
                nt_source_transfer['type'] = 'MultiAppGeneralFieldUserObjectTransfer'
                nt_source_transfer['from_multi_app'] = 'sub'
                nt_source_transfer['source_user_object'] = nt_source_uo_name
                nt_source_transfer['variable'] = 'neutron_source'
                nt_source_transfer['displaced_target_mesh'] = 'true'
                nt_source_transfer['to_blocks'] = 'pipe_' + str(10000+channel_id)
                nt_source_transfer['search_value_conflicts'] = 'false'

                channel_id += 1

    # Channel block definitions
    blocks = [str(int(n))
                for i, n in enumerate(np.linspace(10000,
                                                  10000+total_channels-5,
                                                  total_channels-4))
                ] + [str(int(n))
                     for i, n in enumerate(np.linspace(20000,
                                                       20000+total_channels-5,
                                                       total_channels-4))]
    blocks_1 = "'" + ' '.join(blocks) + "'"
    blocks_2 = "'" + ' '.join(blocks) + ' 30000 30001 30002 30003' + "'"
    blocks_3 = '3 4 5 6 ' + ' '.join(blocks) + ' 30000 30001 30002 30003'
    blocks_3 = "'" + blocks_3 + "'"
    nt_action =  moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Nt')
    nt_action['fission_blocks'] = blocks_3
    nt_action['pre_blocks'] = blocks_3
    heat_aux = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/AuxVariables/heat')
    heat_aux['block'] = blocks_3
    neutron_source_aux = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/AuxVariables/neutron_source')
    neutron_source_aux['block'] = blocks_3
    delayed_neutron_source_aux = moosetree.find(
        sub_root,
        func=lambda n: n.fullpath == '/AuxVariables/delayed_neutron_source')
    delayed_neutron_source_aux['block'] = blocks_3
    salt_mat = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Materials/salt')
    salt_mat['block'] = blocks_2
    bnorm = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Postprocessors/bnorm')
    bnorm['block'] = blocks_3
    total_heat = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Postprocessors/total_heat')
    total_heat['block'] = blocks_3
    T_fluid_blocks_transfer = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Transfers/T_fluid_to_sub_block')
    T_fluid_blocks_transfer['to_blocks'] = blocks_1
    delayed_neutron_transfer = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Transfers/delayed_neutron_to_sub')
    delayed_neutron_transfer['to_blocks'] = blocks_1

    for k in range(1, 7):
        # Scale neutron source by beta_eff for precursor source
        prec_source_kernel = moosetree.find(
            root,
            func=lambda n: n.fullpath == '/Kernels/pre' + str(k) + '_source')
        prec_source_kernel['coef'] = beta[k-1]
        prec_source_supg = moosetree.find(
            root,
            func=lambda n: n.fullpath == '/Kernels/pre' + str(k) + '_supg')
        prec_source_supg['scale_factor'] = beta[k-1]

    # Vacuum boundary definitions
    nt_action['vacuum_boundaries'] = "'104 105 106'"

    pyhit.write(input_file, root)
    pyhit.write(sub_file, sub_root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
    elif len(argv) == 3:
        main(input_base_file=argv[1], input_file=argv[2])
