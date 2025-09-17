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
temperature = 900
inch = 2.54e-2
pitch = np.sqrt(2) * inch
total_width = pitch * 10
control_channel_inner_r = inch
control_channel_outer_r = 3.1992e-2
CHANNEL_VOL_FLOW_RATE = 6.31e-5  # m3/s
TOTAL_VOL_FLOW_RATE = CHANNEL_VOL_FLOW_RATE * 100
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

    control_channel_Dh = (control_channel_outer_r - control_channel_inner_r) * 2
    control_channel_A = pi * (
            control_channel_outer_r ** 2 - control_channel_inner_r ** 2)
    control_channel_Ph = 2 * pi * control_channel_outer_r

    # Read base input file
    root = pyhit.load(input_base_file)

    # Read precursor decay constants from group constant json file
    with open('openmc/xs-data/msre_si.json', 'r') as file:
        xsdata = json.load(file)
    decay_constants = \
        "'" + " ".join(map(str, xsdata['fuel']['900']['DECAY_CONSTANT'])) + "'"

    # PBModelParams
    pb_model_params = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/GlobalParams/PBModelParams')
    pb_model_params['passive_scalar'] = "'pre1 pre2 pre3 pre4 pre5 pre6'"
    pb_model_params['passive_scalar_decay_constant'] = decay_constants
    pb_model_params['global_init_ps'] = "'0 0 0 0 0 0'"
    pb_model_params['ps_scaling_factor'] = "'1e-6 1e-6 1e-6 1e-6 1e-6 1e-6'"

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
    lower_plenum['Dh'] = total_width
    lower_plenum['A'] = total_width ** 2
    lower_plenum['orientation'] = "'0 0 1'"
    lower_plenum['position'] = "'0 0 0'"
    lower_plenum['length'] = lower_plenum_height
    lower_plenum['n_elems'] = 10

    # Upper plenum
    upper_plenum = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/upper_plenum')
    upper_plenum['Dh'] = total_width
    upper_plenum['A'] = total_width ** 2
    upper_plenum['orientation'] = "'0 0 1'"
    upper_plenum['position'] = f"'0 0 {lower_plenum_height+core_height}'"
    upper_plenum['length'] = upper_plenum_height
    upper_plenum['n_elems'] = 10

    # Grid data
    nx = 11
    x = np.linspace(-5 * pitch, 5 * pitch, nx)
    center_idx = [(nx-1)//2-1, (nx-1)//2]

    # Create pipe components and UserObjects
    components = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components')
    pipe_inlets, pipe_outlets = '', ''
    for i in range(nx-1):
        for j in range(nx-1):
            if i == center_idx[0] and j == center_idx[0]:
                x_pos, y_pos = (x[j+2] + x[j]) / 2, (x[i+2] + x[i]) / 2
            elif i in center_idx and j in center_idx:
                continue
            else:
                x_pos, y_pos = (x[j+1] + x[j]) / 2, (x[i+1] + x[i]) / 2
            pipe_name = 'pipe_' + str(i) + str(j)
            pipe_inlets += pipe_name + '(in) '
            pipe_outlets += pipe_name + '(out) '
            components.append(pipe_name)
            pipe = moosetree.find(
                root, func=lambda n: n.fullpath == '/Components/' + pipe_name)
            pipe['type'] = 'PBOneDFluidComponent'
            if i == center_idx[0] and j == center_idx[0]:
                pipe['eos'] = 'eos'
                pipe['Dh'] = control_channel_Dh
                pipe['A'] = control_channel_A
                pipe['Ph'] = control_channel_Ph
                pipe['orientation'] = "'0 0 1'"
                pipe['heat_source_var'] = 'heat'
                pipe['HTC_geometry_type'] = 'Pipe'
                pipe['HTC_user_option'] = 'UserForced'
                pipe['User_defined_HTC_parameters'] = "'4.36 0 0 0 0 0 0'"
            else:
                pipe['input_parameters'] = 'pipe_input'
            pipe['position'] = f"'{x_pos} {y_pos} {lower_plenum_height}'"
            pipe['length'] = core_height
            pipe['n_elems'] = 68
            pipe['scalar_source'] = "'1e6 1e6 1e6 1e6 1e6 1e6'"

            heat_transfer_name = 'heat_flux_' + str(i) + str(j)
            components.append(heat_transfer_name)
            heat_transfer = moosetree.find(
                root,
                func=lambda n:n.fullpath == '/Components/' + heat_transfer_name)
            heat_transfer['type'] = 'HeatTransferWithExternalHeatStructure'
            heat_transfer['T_wall_name'] = 'T_wall'
            heat_transfer['flow_component'] = pipe_name
            heat_transfer['initial_T_wall'] = temperature
            heat_transfer['htc_name'] = 'heat_transfer_coefficient'

    # Lower branch
    lower_branch = moosetree.find(
        root, lambda n: n.fullpath == '/Components/lower_branch')
    lower_branch['K'] = "'" + "0 " * 101 + "'"
    lower_branch['inputs'] = 'lower_plenum(out)'
    lower_branch['outputs'] = "'" + pipe_inlets + "'"
    lower_branch['Area'] = total_width ** 2

    # Upper branch
    upper_branch = moosetree.find(
        root, lambda n: n.fullpath == '/Components/upper_branch')
    lower_branch['K'] = "'" + "0 " * 101 + "'"
    upper_branch['inputs'] = "'" + pipe_outlets + "'"
    upper_branch['outputs'] = 'upper_plenum(in)'
    upper_branch['Area'] = total_width ** 2

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

#    # Salt heat function
#    salt_heat_func = moosetree.find(
#        root, func=lambda n: n.fullpath == '/Functions/salt_heat_func')
#    salt_heat_func['expression'] = "'10.162e6 * sin(pi*((x+0.1107)/1.9736))'"

    # Nearest location transfer to_boundaries
    boundary = [str(int(n)) for i, n in enumerate(np.linspace(200, 299, 100))
                if i not in [44, 45, 54, 55]]
    boundary = ' '.join(boundary)
    T_fluid_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/T_fluid_to_sub')
    T_fluid_transfer['to_boundaries'] = "'" + boundary + "'"
    h_wall_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/h_wall_to_sub')
    h_wall_transfer['to_boundaries'] = "'" + boundary + "'"

    # Sub file
    sub_root = pyhit.load(sub_base_file)

    # BCs
    wall = moosetree.find(
        sub_root, func=lambda n:n.fullpath == '/BCs/wall')
    boundary = [str(int(n)) for i, n in enumerate(np.linspace(200, 299, 100))
                if i not in [45, 54, 55]]
    boundary = ' '.join(boundary)
    wall['boundary'] = "'" + boundary + "'"

#    # Graphite heat function
#    graphite_heat_func = moosetree.find(
#        sub_root, func=lambda n: n.fullpath == '/Functions/graphite_heat_func')
#    graphite_heat_func['expression'] = "'0.7163e6 * cos(1.53 * z - 1.2677) + 0.0127e6'"

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
    for i in range(nx-1):
        for j in range(nx-1):
            if i == center_idx[0] and j == center_idx[0]:
                pass
            elif i in center_idx and j in center_idx:
                continue
            T_wall_uo_name = 'T_wall_uo_' + str(i) + str(j)
            uo.append(T_wall_uo_name)
            T_wall_uo = moosetree.find(
                sub_root,
                func=lambda n: n.fullpath == '/UserObjects/' + T_wall_uo_name)
            T_wall_uo['type'] = 'LayeredSideAverage'
            T_wall_uo['variable'] = 'T_solid'
            T_wall_uo['direction'] = 'z'
            T_wall_uo['num_layers'] = 170
            T_wall_uo['boundary'] = '2' + str(i) + str(j)
            T_wall_uo['execute_on'] = "'initial timestep_end'"
            T_wall_uo['sample_type'] = 'interpolate'

            T_wall_transfer_name = 'T_wall_from_sub_' + str(i) + str(j)
            transfers.append(T_wall_transfer_name)
            T_wall_transfer = moosetree.find(
                root,
                func=lambda n: n.fullpath == '/Transfers/' + T_wall_transfer_name)
            T_wall_transfer['type'] = 'MultiAppGeneralFieldUserObjectTransfer'
            T_wall_transfer['from_multi_app'] = 'sub'
            T_wall_transfer['source_user_object'] = T_wall_uo_name
            T_wall_transfer['variable'] = 'T_wall'
            T_wall_transfer['displaced_target_mesh'] = 'true'
            T_wall_transfer['to_blocks'] = 'pipe_' + str(i) + str(j)
            T_wall_transfer['search_value_conflicts'] = 'false'

            heat_uo_name = 'heat_uo_' + str(i) + str(j)
            uo.append(heat_uo_name)
            heat_uo = moosetree.find(
                sub_root,
                func=lambda n: n.fullpath == '/UserObjects/' + heat_uo_name)
            heat_uo['type'] = 'LayeredAverage'
            heat_uo['variable'] = 'heat'
            heat_uo['direction'] = 'z'
            heat_uo['num_layers'] = 170
            if i == 4 and j == 4:
                block = '244'
            else:
                block = f"'{200 + i * 10 + j} {300 + i * 10 + j}'"
            heat_uo['block'] = block
            heat_uo['execute_on'] = "'initial timestep_end'"
            heat_uo['sample_type'] = 'interpolate'

            heat_transfer_name = 'heat_from_sub_' + str(i) + str(j)
            transfers.append(heat_transfer_name)
            heat_transfer = moosetree.find(
                root,
                func=lambda n: n.fullpath == '/Transfers/' + heat_transfer_name)
            heat_transfer['type'] = 'MultiAppGeneralFieldUserObjectTransfer'
            heat_transfer['from_multi_app'] = 'sub'
            heat_transfer['source_user_object'] = heat_uo_name
            heat_transfer['variable'] = 'heat'
            heat_transfer['displaced_target_mesh'] = 'true'
            heat_transfer['to_blocks'] = 'pipe_' + str(i) + str(j)
            heat_transfer['search_value_conflicts'] = 'false'

    # Channel block definitions
    blocks = [str(int(n)) for i, n in enumerate(np.linspace(200, 399, 200))
                if i not in [45, 54, 55, 144, 145, 154, 155]]
    blocks = ' '.join(blocks)
    blocks = "'" + blocks + "'"
    nt_action =  moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Nt')
    nt_action['fission_blocks'] = blocks
    heat_aux = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/AuxVariables/heat')
    heat_aux['block'] = blocks
    temp_aux = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/AuxKernels/temperature_fluid')
    temp_aux['block'] = blocks
    salt_mat = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Materials/salt')
    salt_mat['block'] = blocks
    bnorm = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Postprocessors/bnorm')
    bnorm['block'] = blocks
    total_heat = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Postprocessors/total_heat')
    total_heat['block'] = blocks
    blocks_2 = [str(int(n)) for i, n in enumerate(np.linspace(200, 399, 200))
                if i not in [44, 45, 54, 55, 144, 145, 154, 155]]
    blocks_2 = ' '.join(blocks_2)
    blocks_2 = "'" + blocks_2 + "'"
    T_fluid_transfer = moosetree.find(
        root, func=lambda n: n.fullpath == '/Transfers/T_fluid_to_sub_block')
    T_fluid_transfer['to_blocks'] = blocks_2

    # Vacuum boundary definitions
    nt_action['vacuum_boundaries'] = "'106 107'"

#            T_fluid_name = 'T_fluid_from_sub_' + str(i) + str(j)
#            transfers.append(T_fluid_name)
#            T_fluid = moosetree.find(
#                root, func=lambda n: n.fullpath == '/Transfers/' + T_fluid_name)
#            T_fluid['type'] = 'MultiAppGeneralFieldNearestLocationTransfer'
#            T_fluid['from_multi_app'] = 'sub'
#            T_fluid['source_variable'] = 'temperature'
#            T_fluid['variable'] = 'T_fluid'
#            T_fluid['displaced_source_mesh'] = 'true'
#            T_fluid['from_blocks'] = 'pipe_' + str(i) + str(j)
#            T_fluid['to_boundaries'] = '2' + str(i) + str(j)
#            T_fluid['search_value_conflicts'] = 'false'

#            h_wall_name = 'h_wall_from_sub_' + str(i) + str(j)
#            transfers.append(h_wall_name)
#            h_wall = moosetree.find(
#                root, func=lambda n: n.fullpath == '/Transfers/' + h_wall_name)
#            h_wall['type'] = 'MultiAppGeneralFieldNearestLocationTransfer'
#            h_wall['from_multi_app'] = 'sub'
#            h_wall['source_variable'] = 'heat_transfer_coefficient'
#            h_wall['variable'] = 'h_wall'
#            h_wall['displaced_source_mesh'] = 'true'
#            h_wall['from_blocks'] = 'pipe_' + str(i) + str(j)
#            h_wall['to_boundaries'] = '2' + str(i) + str(j)
#            h_wall['search_value_conflicts'] = 'false'

    pyhit.write(input_file, root)
    pyhit.write(sub_file, sub_root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
    elif len(argv) == 5:
        main(input_base_file=argv[1], input_file=argv[2],
             sub_base_file=argv[3], sub_file=argv[4])
