#!/usr/bin/env python
"""
setup.py
--------
This module contains the function to build the SAM loop file for TH_2_1_A.

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
total_height = lower_plenum_height + core_height + upper_plenum_height
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
# z position of top of loop
loop_height = 2.9746 # m
downcomer_r_pos = -0.7366 # m

# Graphite properties
graphite_k = 154.797
graphite_cp = 1758.46
graphite_rho = 1860


def main(input_base_file='loop_base.i', input_file='loop.i',
         sub_base_file='loop_sub_base.i', sub_file='loop_sub.i'):

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

#    # Inlet Component
#    inlet = moosetree.find(
#        root, func=lambda n: n.fullpath == '/Components/inlet')
#    inlet['m_bc'] = DENSITY * TOTAL_VOL_FLOW_RATE  # kg/s
#    inlet['T_bc'] = temperature

#    # Outlet Component
#    outlet = moosetree.find(
#        root, func=lambda n: n.fullpath == '/Components/outlet')
#    outlet['p_bc'] = CORE_OUTLET_PRESSURE  # Pa

    # Lower plenum
    lower_plenum = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/lower_plenum')
    lower_plenum['Dh'] = total_width
    lower_plenum['A'] = total_width ** 2
    lower_plenum['orientation'] = "'0 0 1'"
    lower_plenum['position'] = "'0 0 0'"
    lower_plenum['length'] = lower_plenum_height
    lower_plenum['n_elems'] = 4 * 4
    lower_plenum['heat_source_var'] = 'heat'

    # Upper plenum
    upper_plenum = moosetree.find(
        root, func=lambda n: n.fullpath == '/Components/upper_plenum')
    upper_plenum['Dh'] = total_width
    upper_plenum['A'] = total_width ** 2
    upper_plenum['orientation'] = "'0 0 1'"
    upper_plenum['position'] = f"'0 0 {lower_plenum_height+core_height}'"
    upper_plenum['length'] = upper_plenum_height
    upper_plenum['n_elems'] = 5 * 4
    upper_plenum['heat_source_var'] = 'heat'

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
            pipe['n_elems'] = 34 * 4
            # pipe['scalar_source_var'] = "'pre1_source pre2_source pre3_source pre4_source pre5_source pre6_source'"

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

    # Nearest location transfer to_boundaries
    boundary = [str(int(n)) for i, n in enumerate(np.linspace(200, 299, 100))
                if i not in [44, 45, 54, 55]]
    boundary = ' '.join(boundary)
    T_fluid_boundaries_transfer = moosetree.find(
        root, func=lambda n:n.fullpath == '/Transfers/T_fluid_to_sub_boundaries')
    T_fluid_boundaries_transfer['to_boundaries'] = "'" + boundary + "'"
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
            T_wall_uo['sample_type'] = 'direct'

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
            heat_uo['sample_type'] = 'direct'

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

            nt_source_uo_name = 'neutron_source_uo_' + str(i) + str(j)
            uo.append(nt_source_uo_name)
            nt_source_uo = moosetree.find(
                sub_root,
                func=lambda n: n.fullpath == '/UserObjects/' + nt_source_uo_name)
            nt_source_uo['type'] = 'LayeredAverage'
            nt_source_uo['variable'] = 'neutron_source'
            nt_source_uo['direction'] = 'z'
            nt_source_uo['num_layers'] = 170
            if i == 4 and j == 4:
                block = '244'
            else:
                block = f"'{200 + i * 10 + j} {300 + i * 10 + j}'"
            nt_source_uo['block'] = block
            nt_source_uo['execute_on'] = "'initial timestep_end'"
            nt_source_uo['sample_type'] = 'direct'

            nt_source_transfer_name = 'neutron_source_from_sub_' + str(i) + str(j)
            transfers.append(nt_source_transfer_name)
            nt_source_transfer = moosetree.find(
                root,
                func=lambda n: n.fullpath == '/Transfers/' + nt_source_transfer_name)
            nt_source_transfer['type'] = 'MultiAppGeneralFieldUserObjectTransfer'
            nt_source_transfer['from_multi_app'] = 'sub'
            nt_source_transfer['source_user_object'] = nt_source_uo_name
            nt_source_transfer['variable'] = 'neutron_source'
            nt_source_transfer['displaced_target_mesh'] = 'true'
            nt_source_transfer['to_blocks'] = 'pipe_' + str(i) + str(j)
            nt_source_transfer['search_value_conflicts'] = 'false'

    # Channel block definitions
    blocks = [str(int(n)) for i, n in enumerate(np.linspace(200, 399, 200))
                if i not in [45, 54, 55, 144, 145, 154, 155]]
    channel_blocks = "'" + ' '.join(blocks) + "'"
    blocks = '3 4 5 6 ' + ' '.join(blocks)
    blocks = "'" + blocks + "'"
    nt_action =  moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Nt')
    nt_action['fission_blocks'] = blocks
    nt_action['pre_blocks'] = blocks
    heat_aux = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/AuxVariables/heat')
    heat_aux['block'] = blocks
    neutron_source_aux = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/AuxVariables/neutron_source')
    neutron_source_aux['block'] = blocks
    delayed_neutron_source_aux = moosetree.find(
        sub_root,
        func=lambda n: n.fullpath == '/AuxVariables/delayed_neutron_source')
    delayed_neutron_source_aux['block'] = blocks
    salt_mat = moosetree.find(
        sub_root, func=lambda n: n.fullpath == '/Materials/salt')
    salt_mat['block'] = channel_blocks
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
    T_fluid_blocks_transfer = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Transfers/T_fluid_to_sub_block')
    T_fluid_blocks_transfer['to_blocks'] = blocks_2
    delayed_neutron_transfer = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Transfers/delayed_neutron_to_sub')
    delayed_neutron_transfer['to_blocks'] = blocks_2
#    pipes = ['pipe_' + str(int(n))
#             for i, n in enumerate(np.linspace(200, 299, 100))
#             if i not in [44, 45, 54, 55]]
#    pipes = ' '.join(pipes)
#    pipes = "'" + pipes + "'"
#    delayed_neutron_transfer['from_blocks'] = pipes
#    T_fluid_transfer['from_blocks'] = pipes

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
    nt_action['vacuum_boundaries'] = "'106 107'"

    # External loop
    downcomer = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/downcomer')
    downcomer['length'] = core_height + lower_plenum_height
    downcomer['position'] = \
        f"'{downcomer_r_pos} 0 {core_height + lower_plenum_height}'"
#    downcomer['length'] = 1.7272
#    downcomer['position'] = \
#        f"'{downcomer_r_pos} 0 1.7272'"

    pipe1_s1 = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/pipe1_s1')
    pipe1_s1['position'] = f"'0 0 {total_height}'"

    pipe1_s2 = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/pipe1_s2')
    # Tweak from original virtual test bed input file
    pipe1_s2['length'] = loop_height - total_height
    pipe1_s2['position'] = f"'1.8288 0 {total_height}'"

    pump = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/pump')
    pump['Head'] = 43909.58

    hx = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/fixed_hx')
    # total heat divided by hx pipe volume
    hx['heat_source'] = -8e6 / 11 / (np.pi * 1.0183e-1 ** 2 * 2.5298)

    pipe3_s1 = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/pipe3_s1')
    pipe3_s1['length'] = loop_height - total_height + upper_plenum_height

    pipe3_s2 = moosetree.find(
        root,
        func=lambda n: n.fullpath == '/Components/pipe3_s2')
    pipe3_s2['position'] = f"'-1.7678 0 {core_height+lower_plenum_height}'"

    pyhit.write(input_file, root)
    pyhit.write(sub_file, sub_root)


if __name__ == "__main__":
    if len(argv) == 1:
        main()
    elif len(argv) == 5:
        main(input_base_file=argv[1], input_file=argv[2],
             sub_base_file=argv[3], sub_file=argv[4])
