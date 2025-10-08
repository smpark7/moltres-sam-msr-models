[GlobalParams]
  global_init_P = 1.0e5
  global_init_V = 0.25
  global_init_T = 900
  scaling_factor_var = '1 1e-3 1e-6'
  gravity = '0 0 -9.8'
  p_order = 2
  [PBModelParams]
  []
[]

[AuxVariables]
  [T_wall]
    family = LAGRANGE
    order = SECOND
  []
  [heat]
    initial_condition = 5e6
  []
  [neutron_source]
  []
  [delayed_neutron_source]
  []
[]

[EOS]
  [eos]
    type = SaltEquationOfState
  []
[]

[Components]
  [lower_plenum]
    type = PBOneDFluidComponent
    eos = eos
    orientation = '0 0 1'
  []
  [upper_plenum]
    type = PBOneDFluidComponent
    eos = eos
    orientation = '0 0 1'
  []
  [lower_branch]
    type = PBBranch
    eos = eos
  []
  [upper_branch]
    type = PBBranch
    eos = eos
  []

  # External loop
  [downcomer]
    type           = PBOneDFluidComponent
    A              = 0.1589
    Dh             = 0.0508
    length         = 1.70027
    n_elems        = 18
    orientation    = '0 0 -1'
    position       = '-0.7366 0 1.70027'
    eos            = eos
  []
  [j_dn_pl]
    type    = PBBranch
    Area    = 0.1155
    K       = '0.0 0.0'
    eos     = eos
    inputs  = 'downcomer(out)'
    outputs = 'lower_plenum(in)'
  []

  [j_up_ps1]
    type    = PBBranch
    Area    = 0.1155
    K       = '0.0 0.0'
    eos     = eos
    inputs  = 'upper_plenum(out)'
    outputs = 'pipe1_s1(in)'
  []

  [pipe1_s1]  # Connecting core to pump, horizontal section
    type        = PBOneDFluidComponent
    A           = 0.01267
    Dh          = 0.127
    length      = 1.8288
    n_elems     = 19
    orientation = '1 0 0'
    position    = '0 0 2.1618'
    eos         = eos
  []

  [j1]
    type    = PBBranch
    Area    = 0.01292
    K       = '0.0 0.0'
    eos     = eos
    inputs  = 'pipe1_s1(out)'
    outputs = 'pipe1_s2(in)'
  []

  [pipe1_s2]  # vertical section
    type        = PBOneDFluidComponent
    A           = 0.01267
    Dh          = 0.127
    length      = 0.8128
    n_elems     = 9
    orientation = '0 0 1'
    position    = '1.8288 0 2.1618'
    eos         = eos
  []

  #
  # ====== pump ======
  #

  [pump]
    type      = PBPump
    Area      = 0.01292
    K         = '0.15 0.1'
    eos       = eos
    inputs    = 'pipe1_s2(out)'
    outputs   = 'pipe2(in)'
    initial_P = 1.1e5
  # Head_fn   = f_pump_head
    Head      = 43909.58
  []

  [pipe2]     # Connecting the pump to HX
    type        = PBOneDFluidComponent
    A           = 0.01267
    Dh          = 0.127
    length      = 1.0668
    n_elems     = 11
    orientation = '-1 0 0'
    position    = '1.8288 0 2.9746'
    eos         = eos
  []
  [j2]    # junction connect to heat exchanger
    type    = PBBranch
    Area    = 0.01267
    K       = '0.0 0.0'
    eos     = eos
    inputs  = 'pipe2(out)'
    outputs = 'fixed_hx(in)'
  []

  [fixed_hx]
    type = PBOneDFluidComponent
    position = '0.762 0 2.9746'
    orientation = '-1 0 0'
    length = 2.5298
    n_elems = 26
    eos = eos
    A = 1.0183E-01
    Dh = 2.0945E-02
  []

#  #
#  # ====== Customized U-tube heat exchanger ======
#  #
#  [./hx_shell]
#    type        = PBOneDFluidComponent
#    position    = '0.762 0 2.9746'
#    orientation = '-1 0 0'
#    length      = 2.5298
#    n_elems     = 26
#    eos         = eos
#    heat_source = 0
#    A           = 1.0183E-01
#    Dh          = 2.0945E-02
#  [../]
#
#  [./hx_tube1]
#    type        = PBOneDFluidComponent
#    position    = '-1.7678 0 3.0762'
#    orientation = '1 0 0'
#    length      = 2.5298
#    n_elems     = 26
#    eos         = hx_salt_eos
#    heat_source = 0
#    A           = 2.7885E-02
#    Dh          = 1.0566E-02
#    initial_T   = 824.8167
#  [../]
#  [./hx_j1]
#    type      = PBBranch
#    eos       = hx_salt_eos
#    inputs    = 'hx_tube1(out)'
#    outputs   = 'hx_tube2(in)'
#    K         = '0 0'
#    Area      = 2.7885E-02
#    initial_T = 824.8167
#  [../]
#  [./hx_tube2]
#    type        = PBOneDFluidComponent
#    position    = '0.762 0 3.0762'
#    orientation = '0 0 -1'
#    length      = 0.2032
#    n_elems     = 2
#    eos         = hx_salt_eos
#    heat_source = 0
#    A           = 2.7885E-02
#    Dh          = 1.0566E-02
#    initial_T   = 824.8167
#  [../]
#  [./hx_j2]
#    type      = PBBranch
#    eos       = hx_salt_eos
#    inputs    = 'hx_tube2(out)'
#    outputs   = 'hx_tube3(in)'
#    K         = '0 0'
#    Area      = 2.7885E-02
#    initial_T = 824.8167
#  [../]
#  [./hx_tube3]
#    type        = PBOneDFluidComponent
#    position    = '0.762 2.873 0'
#    orientation = '-1 0 0'
#    length      = 2.5298
#    n_elems     = 26
#    eos         = hx_salt_eos
#    heat_source = 0
#    A           = 2.7885E-02
#    Dh          = 1.0566E-02
#    initial_T   = 824.8167
#  [../]
#
#  [./hx_s_in]
#    type  = PBTDJ
#    input = 'hx_tube1(in)'
#    eos   = hx_salt_eos
#    v_bc  = 1.6
#    T_bc  = 824.8167
#  [../]
#  [./hx_s_out]
#    type  = PBTDV
#    input = 'hx_tube3(out)'
#    eos   = hx_salt_eos
#    p_bc  = 1.0e5
#    T_bc  = 866.4833
#  [../]
#
#  [./hx_wall1]
#    type               = PBCoupledHeatStructure
#    position           = '-1.7678 3.0762 0'
#    orientation        = '1 0 0'
#    length             = 2.5298
#    hs_type            = cylinder
#    radius_i           = 5.2832E-03
#    width_of_hs        = 1.0668E-03
#    elem_number_radial = 2
#    elem_number_axial  = 26
#    dim_hs             = 2
#    material_hs        = 'alloy-mat'
#    Ts_init            = 824.8167
#
#    HS_BC_type                    = 'Coupled Coupled'
#    name_comp_left                = hx_tube1
#    HT_surface_area_density_left  = 8.6290E+02
#    name_comp_right               = hx_shell
#    HT_surface_area_density_right = 2.3629E+02
#  [../]
#
#  [./hx_wall2]
#    type               = PBCoupledHeatStructure
#    position           = '0.762 2.873 0'
#    orientation        = '-1 0 0'
#    length             = 2.5298
#    hs_type            = cylinder
#    radius_i           = 5.2832E-03
#    width_of_hs        = 1.0668E-03
#    elem_number_radial = 2
#    elem_number_axial  = 26
#    dim_hs             = 2
#    material_hs        = 'alloy-mat'
#    Ts_init            = 824.8167
#
#    HS_BC_type                    = 'Coupled Coupled'
#    name_comp_left                = hx_tube3
#    HT_surface_area_density_left  = 8.6290E+02
#    name_comp_right               = hx_shell
#    HT_surface_area_density_right = 2.3629E+02
#  [../]

  [./j3]
    type    = PBBranch
    Area    = 0.01267
    K       = '0.0 1e3 0.0'
    eos     = eos
    inputs  = 'fixed_hx(out) pipe_ref(out)'
    outputs = 'pipe3_s1(in)'
  [../]

  [./pipe_ref]
    type        = PBOneDFluidComponent
    A           = 0.01267
    Dh          = 0.127
    length      = 0.1
    n_elems     = 2
    orientation = '1 0 0'
    position    = '-1.8678 0 2.9746'
    eos         = eos
  [../]
  [./ref_p]
    type  = PBTDV
    eos   = eos
    T_bc  = 908.15
    p_bc  = 1.233351e+05
    input = 'pipe_ref(in)'
  [../]

  [./pipe3_s1]  # Connecting hx to downcomer
    type        = PBOneDFluidComponent
    A           = 0.01267
    Dh          = 0.127
    length      = 1.2474
    n_elems     = 13
    orientation = '0 0 -1'
    position    = '-1.7678 0 2.9746'
    eos         = eos
  [../]

  [./j4]
    type    = PBBranch
    Area    = 0.01267
    K       = '0.0 0.0'
    eos     = eos
    inputs  = 'pipe3_s1(out)'
    outputs = 'pipe3_s2(in)'
  [../]

  [./pipe3_s2]
    type        = PBOneDFluidComponent
    A           = 0.01267
    Dh          = 0.127
    length      = 1.0312
    n_elems     = 11
    orientation = '1 0 0'
    position    = '-1.7678 0 1.7272'
    eos         = eos
  [../]

  [./j5]
    type    = PBBranch
    Area    = 0.01267
    K       = '0.0 0.0'
    eos     = eos
    inputs  = 'pipe3_s2(out)'
    outputs = 'downcomer(in)'
  [../]
[]

[ComponentInputParameters]
  [pipe_input]
    type = PBOneDFluidComponentParameters
    eos = eos
    orientation = '0 0 1'
  []
[]

[Kernels]
  [pre1_source]
    type = CoupledForce
    variable = pre1
    v = neutron_source
  []
  [pre2_source]
    type = CoupledForce
    variable = pre2
    v = neutron_source
  []
  [pre3_source]
    type = CoupledForce
    variable = pre3
    v = neutron_source
  []
  [pre4_source]
    type = CoupledForce
    variable = pre4
    v = neutron_source
  []
  [pre5_source]
    type = CoupledForce
    variable = pre5
    v = neutron_source
  []
  [pre6_source]
    type = CoupledForce
    variable = pre6
    v = neutron_source
  []
  [pre1_supg]
    type = CoupledForceSUPG
    variable = pre1
    coupled_variable = neutron_source
  []
  [pre2_supg]
    type = CoupledForceSUPG
    variable = pre2
    coupled_variable = neutron_source
  []
  [pre3_supg]
    type = CoupledForceSUPG
    variable = pre3
    coupled_variable = neutron_source
  []
  [pre4_supg]
    type = CoupledForceSUPG
    variable = pre4
    coupled_variable = neutron_source
  []
  [pre5_supg]
    type = CoupledForceSUPG
    variable = pre5
    coupled_variable = neutron_source
  []
  [pre6_supg]
    type = CoupledForceSUPG
    variable = pre6
    coupled_variable = neutron_source
  []
[]

[AuxKernels]
  [delayed_neutron]
    type = ParsedAux
    variable = delayed_neutron_source
    coupled_variables = 'pre1 pre2 pre3 pre4 pre5 pre6'
    expression = ''
  []
[]

[Functions]
  [rho_func]
    type = PiecewiseLinear
  []
  [mu_func]
    type = PiecewiseLinear
  []
  [dt_func]
    type = ParsedFunction
#    expression = 'if(t<10, 0.2, 2)'
    expression = 0.2
  []
[]

[UserObjects]
[]

[Preconditioning]
  [SMP_PJFNK]
    type = SMP
    full = true
    solve_type = 'PJFNK'
    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
    petsc_options_value = 'lu superlu_dist'
  []
[]

[Executioner]
#  type = Steady
  type = Transient
#  dt = 0.2
#  num_steps = 1
  end_time = 100

  steady_state_detection = true
  steady_state_start_time = 10

  petsc_options_iname = '-ksp_gmres_restart'
  petsc_options_value = '100'

  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8
  nl_max_its = 20

  l_tol = 1e-4
  l_max_its = 100

  auto_advance = true
  fixed_point_max_its = 20
  fixed_point_rel_tol = 1e-7
  fixed_point_abs_tol = 1e-6

  [Quadrature]
    type = SIMPSON
    order = SECOND
  []
  [TimeStepper]
    type = FunctionDT
    function = dt_func
  []
[]

[MultiApps]
  [sub]
    type = FullSolveMultiApp
    app_type = MoltresApp
    library_path = '/work/10525/smpark3/ls6/projects/moltres/lib'
#    library_path = '/home/smpark/projects/moltres-sam/lib'
    positions = '0 0 0'
    input_files = 'input_sub.i'
    execute_on = timestep_end
    keep_solution_during_restore = true
    keep_aux_solution_during_restore = true
  []
[]

[Transfers]
  [T_fluid_to_sub_boundaries]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = T_wall_fluid
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_to_sub_boundaries_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = T_wall_fluid
    displaced_source_mesh = true
    to_boundaries = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [T_fluid_to_sub_block]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = temperature
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_to_sub_block_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = temperature
    displaced_source_mesh = true
    to_blocks = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [T_plenum_to_sub_block_plenum]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = temperature
    displaced_source_mesh = true
    to_blocks = '3 4 5 6'
    from_blocks = 'lower_plenum upper_plenum'
    search_value_conflicts = false
  []
  [h_wall_to_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = heat_transfer_coefficient
    variable = h_wall
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [h_wall_to_sub_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = heat_transfer_coefficient
    variable = h_wall
    displaced_source_mesh = true
    to_boundaries = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [delayed_neutron_to_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = delayed_neutron_source
    variable = delayed_neutron_source
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [delayed_neutron_to_sub_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = delayed_neutron_source
    variable = delayed_neutron_source
    displaced_source_mesh = true
    to_blocks = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [delayed_neutron_to_sub_plenum]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = delayed_neutron_source
    variable = delayed_neutron_source
    displaced_source_mesh = true
    to_blocks = '3 4 5 6'
    from_blocks = 'lower_plenum upper_plenum'
    search_value_conflicts = false
  []
  [heat_from_sub_lower_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sub
    source_user_object = heat_uo_lower_plenum
    variable = heat
    displaced_target_mesh = true
    to_blocks = lower_plenum
    search_value_conflicts = false
  []
  [heat_from_sub_upper_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sub
    source_user_object = heat_uo_upper_plenum
    variable = heat
    displaced_target_mesh = true
    to_blocks = upper_plenum
    search_value_conflicts = false
  []
  [neutron_source_from_sub_lower_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sub
    source_user_object = nt_source_uo_lower_plenum
    variable = neutron_source
    displaced_target_mesh = true
    to_blocks = lower_plenum
    search_value_conflicts = false
  []
  [neutron_source_from_sub_upper_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sub
    source_user_object = nt_source_uo_upper_plenum
    variable = neutron_source
    displaced_target_mesh = true
    to_blocks = upper_plenum
    search_value_conflicts = false
  []
[]

[Postprocessors]
  [outlet_temperature]
    type = ComponentBoundaryVariableValue
    input = upper_plenum(out)
    variable = temperature
  []
  [outlet_velocity]
    type = ComponentBoundaryVariableValue
    input = upper_plenum(out)
    variable = velocity
  []
  [outlet_pressure]
    type = ComponentBoundaryVariableValue
    input = upper_plenum(out)
    variable = pressure
  []
  [control_temperature]
    type = ComponentBoundaryVariableValue
    input = pipe_44(out)
    variable = temperature
  []
  [control_velocity]
    type = ComponentBoundaryVariableValue
    input = pipe_44(out)
    variable = velocity
  []
  [pipe_43_temperature]
    type = ComponentBoundaryVariableValue
    input = pipe_43(out)
    variable = temperature
  []
  [pipe_43_velocity]
    type = ComponentBoundaryVariableValue
    input = pipe_43(out)
    variable = velocity
  []
[]

[VectorPostprocessors]
#  [temperature]
#    type = NodalValueSampler
#    variable = temperature
#    sort_by = 'z'
#    block = 'pipe1 pipe2 pipe3 pipe4'
#    use_displaced_mesh = true
#  []
#  [pressure]
#    type = NodalValueSampler
#    variable = pressure
#    sort_by = 'z'
#    block = 'pipe1 pipe2 pipe3 pipe4'
#    use_displaced_mesh = true
#  []
#  [velocity]
#    type = NodalValueSampler
#    variable = velocity
#    sort_by = 'z'
#    block = 'pipe1 pipe2 pipe3 pipe4'
#    use_displaced_mesh = true
#  []
#  [density]
#    type = NodalValueSampler
#    variable = rho
#    sort_by = 'z'
#    block = 'pipe1 pipe2 pipe3 pipe4'
#    use_displaced_mesh = true
#  []
#  [wall_temperature]
#    type = NodalValueSampler
#    variable = Tw
#    sort_by = 'z'
#    block = 'pipe1 pipe2 pipe3 pipe4'
#    use_displaced_mesh = true
#  []
[]

[Outputs]
  perf_graph = true
  csv = true
  [console]
    type = Console
  []
  [out_displaced]
    type = Exodus
    use_displaced = true
    execute_on = 'initial timestep_end'
    sequence = false
  []
[]
