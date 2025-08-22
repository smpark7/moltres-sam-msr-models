[GlobalParams]
  global_init_P = 1.0e5
  global_init_V = 0.25
  global_init_T = 900
  scaling_factor_var = '1 1e-3 1e-6'
[]

[AuxVariables]
  [T_wall]
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
    f = 0
  []
  [upper_plenum]
    type = PBOneDFluidComponent
    eos = eos
    orientation = '0 0 1'
    f = 0
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
#  [surface_coupling_12]
#    type = SurfaceCoupling
#    surface1_name = pipe1:solid:top_wall
#    surface2_name = pipe2:solid:bottom_wall
#    coupling_type = GapHeatTransfer
#    h_gap = 1e9
#  []
[]

[ComponentInputParameters]
  [pipe_input]
    type = PBOneDFluidComponentParameters
    eos = eos
    orientation = '0 0 1'
    f = 0
  []
[]

[Functions]
  [rho_func]
    type = PiecewiseLinear
  []
  [mu_func]
    type = PiecewiseLinear
  []
  [salt_heat_func]
    type = ParsedFunction
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
  dt = 1
  end_time = 20

  petsc_options_iname = '-ksp_gmres_restart'
  petsc_options_value = '100'

  nl_rel_tol = 1e-7
  nl_abs_tol = 1e-6
  nl_max_its = 20

  l_tol = 1e-4
  l_max_its = 100

  auto_advance = true
  fixed_point_max_its = 20
  fixed_point_rel_tol = 1e-7
  fixed_point_abs_tol = 1e-6

  [Quadrature]
    type = TRAP
    order = FIRST
  []
[]

[MultiApps]
  [sub]
    type = FullSolveMultiApp
    app_type = MoltresApp
    library_path = '/work/10525/smpark3/ls6/projects/moltres/lib'
    positions = '0 0 0'
    input_files = 'input_sub.i'
    execute_on = timestep_end
    keep_solution_during_restore = true
    keep_aux_solution_during_restore = true
  []
[]

[Transfers]
  [T_wall_from_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    from_multi_app = sub
    source_variable = T_solid
    variable = T_wall
    from_blocks = '2'
    num_nearest_points = 40
    displaced_target_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_to_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = T_fluid
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_to_sub_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = temperature
    variable = T_fluid
    displaced_source_mesh = true
    to_boundaries = '244'
    from_blocks = 'pipe_44'
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
