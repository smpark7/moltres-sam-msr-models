[GlobalParams]
  global_init_P = 1.0e5
  global_init_V = 0.25
  global_init_T = 900
  scaling_factor_var = '1 1e-3 1e-6'
  p_order = 2
  [PBModelParams]
  []
[]

[AuxVariables]
  [T_wall]
  []
  [heat]
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
  [inlet]
    type = PBTDJ
    input = 'lower_plenum(in)'
    eos = eos
  []
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
  [outlet]
    type = PBTDV
    input = 'upper_plenum(out)'
    eos = eos
  []
[]

[ComponentInputParameters]
  [pipe_input]
    type = PBOneDFluidComponentParameters
    eos = eos
    orientation = '0 0 1'
  []
  [control_input]
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
    expression = 'if(t<1, 0.2, 2)'
  []
[]

[UserObjects]
[]

[Preconditioning]
  [SMP_PJFNK]
    type = SMP
    full = true
    solve_type = 'PJFNK'
#    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
#    petsc_options_value = 'lu superlu_dist'
    petsc_options_iname = '-pc_type'
    petsc_options_value = 'ilu'
  []
[]

[Executioner]
  type = Transient
  end_time = 100

  steady_state_detection = true
  steady_state_start_time = 10

  petsc_options_iname = '-ksp_gmres_restart'
  petsc_options_value = '200'

  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8
  nl_max_its = 20

  l_tol = 1e-4
  l_max_its = 200

  auto_advance = true
  fixed_point_max_its = 20
  fixed_point_rel_tol = 1e-7
  fixed_point_abs_tol = 1e-6

  [Quadrature]
    type = TRAP
    order = FIRST
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
    to_boundaries = '30000 30001 30002 30003'
    from_blocks = 'control_0 control_1 control_2 control_3'
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
    to_blocks = '30000 30001 30002 30003'
    from_blocks = 'control_0 control_1 control_2 control_3'
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
    to_boundaries = '30000 30001 30002 30003'
    from_blocks = 'control_0 control_1 control_2 control_3'
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
    to_blocks = '30000 30001 30002 30003'
    from_blocks = 'control_0 control_1 control_2 control_3'
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
    input = control_0(out)
    variable = temperature
  []
  [control_velocity]
    type = ComponentBoundaryVariableValue
    input = control_0(out)
    variable = velocity
  []
  [pipe_10000_temperature]
    type = ComponentBoundaryVariableValue
    input = pipe_10000(out)
    variable = temperature
  []
  [pipe_10000_velocity]
    type = ComponentBoundaryVariableValue
    input = pipe_10000(out)
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
