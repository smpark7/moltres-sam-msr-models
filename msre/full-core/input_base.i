[Mesh]
  [graphite]
    type = FileMeshGenerator
    file = 'mesh_in.e'
  []
[]

[Variables]
  [T_solid]
    family = LAGRANGE
    order = FIRST
    initial_condition = 900
    scaling = 1e-6
  []
[]

[AuxVariables]
  [h_wall]
    family = LAGRANGE
    order = FIRST
    block = '0 2'
    initial_condition = 1e3
  []
  [T_fluid]
    family = LAGRANGE
    order = FIRST
    block = '0 2'
    initial_condition = 900
  []
[]

[Kernels]
  [diffusion]
    type = MatDiffusion
    variable = T_solid
    diffusivity = 'k'
  []
  [source]
    type = HeatSource
    variable = T_solid
    function = graphite_heat_func
  []
[]

[Materials]
  [graphite]
    type = GenericConstantMaterial
  []
[]

[BCs]
  [wall]
    type = CoupledConvectiveHeatFluxBC
    variable = T_solid
    htc = h_wall
    T_infinity = T_fluid
  []
[]

[Functions]
  [graphite_heat_func]
    type = ParsedFunction
  []
[]

[UserObjects]
[]

[Preconditioning]
  [SMP_PJFNK]
    type = SMP
    solve_type = 'PJFNK'
    petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
    petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
#    full = true
#    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
#    petsc_options_value = 'lu superlu_dist'
  []
[]

[Executioner]
#  type = Steady
  type = Transient
  dt = 1
  end_time = 100

#  petsc_options_iname = '-ksp_gmres_restart'
#  petsc_options_value = '100'

  nl_rel_tol = 1e-9
  nl_abs_tol = 1e-8
  nl_max_its = 20

  l_tol = 1e-4
  l_max_its = 100

  fixed_point_max_its = 20
  fixed_point_rel_tol = 1e-9
  fixed_point_abs_tol = 1e-8

  [Quadrature]
    type = TRAP
    order = FIRST
  []
  transformed_variables = 'T_solid'
[]

[MultiApps]
  [sub]
    type = TransientMultiApp
    app_type = SamApp
    positions = '0 0 0'
    input_files = 'input_sub.i'
    execute_on = timestep_end
#    max_procs_per_app = 32
  []
[]

[Transfers]
  [T_wall_to_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = sub
    source_variable = T_solid
    variable = T_wall
    from_blocks = '2'
    num_nearest_points = 40
    displaced_target_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_from_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    from_multi_app = sub
    source_variable = temperature
    variable = T_fluid
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_from_sub_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    from_multi_app = sub
    source_variable = temperature
    variable = T_fluid
    displaced_source_mesh = true
    to_boundaries = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [h_wall_from_sub]
    type = MultiAppGeneralFieldNearestLocationTransfer
    from_multi_app = sub
    source_variable = heat_transfer_coefficient
    variable = h_wall
    displaced_source_mesh = true
    search_value_conflicts = false
  []
[]

[Postprocessors]
[]

[VectorPostprocessors]
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
