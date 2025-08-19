[GlobalParams]
  num_groups = 2
  num_precursor_groups = 6
  use_exp_form = false
  group_fluxes = 'group1 group2'
  temperature = 922
  sss2_input = true
  account_delayed = false
[]

[Problem]
  type = EigenProblem
  bx_norm = bnorm
[]

[Mesh]
  [graphite]
    type = FileMeshGenerator
    file = 'nt_mesh_quad_base_in.e'
  []
[]

[Nt]
  family = LAGRANGE
  order = SECOND
  var_name_base = group
  fission_blocks = '10 11 15'
  pre_blocks = '10 11 15'
  create_temperature_var = false
  eigen = true
[]

[Variables]
  [T_solid]
    family = LAGRANGE
    order = FIRST
    block = '0 1 2'
    initial_condition = 900
    scaling = 1e-6
  []
[]

[AuxVariables]
  [h_wall]
    family = LAGRANGE
    order = FIRST
    block = '10 11 15'
    initial_condition = 1e3
  []
  [T_fluid]
    family = LAGRANGE
    order = FIRST
    block = '10 11 15'
    initial_condition = 900
  []
[]

[Kernels]
  [diffusion]
    type = MatDiffusion
    variable = T_solid
    block = '0 1 2'
    diffusivity = 'k'
  []
  [source]
    type = HeatSource
    variable = T_solid
    block = '0 1 2'
    function = graphite_heat_func
  []
[]

[Materials]
  [graphite]
    type = MoltresJsonMaterial
    base_file = 'xsdata/xsdata-meter.json'
    material_key = 'graphite'
    block = '0 1 2'
    interp_type = 'none'
    prop_names = 'k cp rho'
    prop_values = '154.797 1758.46 1860'
    temperature = T_solid
  []
  [salt]
    type = MoltresJsonMaterial
    base_file = 'xsdata/xsdata-meter.json'
    material_key = 'fuel'
    block = '10 11 15'
    interp_type = 'none'
    prop_names = 'k cp rho'
    prop_values = '10.1 2386 2327.5'
    temperature = T_fluid
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
  type = Eigenvalue
  free_power_iterations = 4
  initial_eigenvalue = 1

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
  line_search = 'none'

  nl_abs_tol = 1e-10

  fixed_point_max_its = 20
  fixed_point_rel_tol = 1e-9
  fixed_point_abs_tol = 1e-8
[]

[MultiApps]
  [sub]
    type = TransientMultiApp
    app_type = SamApp
    positions = '0 0 0'
    input_files = 'input_sub.i'
    execute_on = timestep_end
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
  [bnorm]
    type = ElmIntegTotFissNtsPostprocessor
    block = '10 11 15'
    execute_on = linear
  []
  [eigenvalue]
    type = VectorPostprocessorComponent
    vectorpostprocessor = eigenvalues
    vector_name = eigen_values_real
    index = 0
  []
  [max_temp]
    type = NodalExtremeValue
    variable = T_solid
    block = '0 1 2'
    value_type = min
  []
[]

[VectorPostprocessors]
  [eigenvalues]
    type = Eigenvalues
    inverse_eigenvalue = true
    outputs = console
  []
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
    discontinuous = true
  []
[]
