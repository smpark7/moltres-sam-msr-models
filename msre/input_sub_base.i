[GlobalParams]
  num_groups = 2
  num_precursor_groups = 6
  use_exp_form = false
  group_fluxes = 'group1 group2'
  sss2_input = true
  account_delayed = false
  temperature = temperature
[]

[Problem]
  type = EigenProblem
  bx_norm = bnorm
[]

[Mesh]
#  parallel_type = distributed
  [graphite]
    type = FileMeshGenerator
    file = 'nt_mesh_coarse_in.e'
  []
[]

[Nt]
  family = LAGRANGE
  order = SECOND
  var_name_base = group
  fission_blocks = '10 11 15'
#  pre_blocks = '10 11 15'
  create_temperature_var = false
  eigen = true
[]

[Variables]
  [T_solid]
    family = LAGRANGE
    order = SECOND
    block = '0 1 2'
    initial_condition = 900
    scaling = 1e-6
  []
[]

[AuxVariables]
  [temperature]
    family = MONOMIAL
    order = SECOND
  []
  [h_wall]
    family = LAGRANGE
    order = SECOND
    block = '0 2'
    initial_condition = 1e3
  []
  [T_fluid]
    family = LAGRANGE
    order = SECOND
    initial_condition = 900
  []
  [heat]
    family = MONOMIAL
    order = SECOND
  []
  [pre1_source]
    family = MONOMIAL
    order = SECOND
  []
  [pre2_source]
    family = MONOMIAL
    order = SECOND
  []
  [pre3_source]
    family = MONOMIAL
    order = SECOND
  []
  [pre4_source]
    family = MONOMIAL
    order = SECOND
  []
  [pre5_source]
    family = MONOMIAL
    order = SECOND
  []
  [pre6_source]
    family = MONOMIAL
    order = SECOND
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
    type = GammaHeatSource
    variable = T_solid
    block = '0 1 2'
    average_fission_heat = 1
    gamma = gamma_func
  []
[]

[AuxKernels]
  [temperature_fluid]
    type = ProjectionAux
    variable = temperature
    v = T_fluid
    block = '10 11 15'
  []
  [temperature_solid]
    type = ProjectionAux
    variable = temperature
    v = T_solid
    block = '0 1 2'
  []
  [heat_source_fluid]
    type = FissionHeatSourceAux
    variable = heat
    tot_fission_heat = total_heat
    power = ${fparse 8e6 / 11 * (1 - 0.078)}
  []
  [pre1_source]
    type = PrecursorSourceAux
    variable = pre1_source
    precursor_group_number = 1
  []
  [pre2_source]
    type = PrecursorSourceAux
    variable = pre2_source
    precursor_group_number = 2
  []
  [pre3_source]
    type = PrecursorSourceAux
    variable = pre3_source
    precursor_group_number = 3
  []
  [pre4_source]
    type = PrecursorSourceAux
    variable = pre4_source
    precursor_group_number = 4
  []
  [pre5_source]
    type = PrecursorSourceAux
    variable = pre5_source
    precursor_group_number = 5
  []
  [pre6_source]
    type = PrecursorSourceAux
    variable = pre6_source
    precursor_group_number = 6
  []
[]

[Functions]
  [gamma_func]
    type = ParsedFunction
    expression = '8e6 / 11 * 0.078 / volume'
    symbol_names = 'volume'
    symbol_values = 'graphite_volume'
  []
[]

[Materials]
  [graphite]
    type = MoltresJsonMaterial
#    base_file = 'xsdata/xsdata-meter.json'
    base_file = 'openmc/xs-data/msre_si.json'
    material_key = 'graphite'
    block = '0 1 2'
    interp_type = 'linear'
    prop_names = 'k cp rho'
    prop_values = '154.797 1758.46 1860'
    temperature = T_solid
  []
  [salt]
    type = MoltresJsonMaterial
#    base_file = 'xsdata/xsdata-meter.json'
    base_file = 'openmc/xs-data/msre_si.json'
    material_key = 'fuel'
    block = '10 11 15'
    interp_type = 'linear'
    prop_names = 'k cp rho'
    prop_values = '10.1 2386 2327.5'
    temperature = T_fluid
  []
[]

[BCs]
  [wall]
    type = CoupledConvectiveHeatFluxBC
    variable = T_solid
    boundary = '100'
    htc = h_wall
    T_infinity = T_fluid
  []
[]

[UserObjects]
[]

[Executioner]
#  type = Transient
#  dt = 1e-3
#  end_time = 20
  type = Eigenvalue
  free_power_iterations = 2
  initial_eigenvalue = 1
  normal_factor = '${fparse 8e6 / 11}'
  normalization = total_heat

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
  line_search = 'none'

#  nl_abs_tol = 1e-10
  nl_abs_tol = 1e-8
#  l_tol = 1e-3
[]

#[MultiApps]
#  [sub]
#    type = TransientMultiApp
#    app_type = SamApp
#    positions = '0 0 0'
#    input_files = 'input_sub.i'
#    execute_on = timestep_end
#  []
#[]

#[Transfers]
#  [T_wall_to_sub]
#    type = MultiAppGeneralFieldNearestLocationTransfer
#    to_multi_app = sub
#    source_variable = T_solid
#    variable = T_wall
#    from_blocks = '2'
#    num_nearest_points = 40
#    displaced_target_mesh = true
#    search_value_conflicts = false
#  []
#  [T_fluid_from_sub]
#    type = MultiAppGeneralFieldNearestLocationTransfer
#    from_multi_app = sub
#    source_variable = temperature
#    variable = T_fluid
#    displaced_source_mesh = true
#    search_value_conflicts = false
#  []
#  [T_fluid_from_sub_control_channel]
#    type = MultiAppGeneralFieldNearestLocationTransfer
#    from_multi_app = sub
#    source_variable = temperature
#    variable = T_fluid
#    displaced_source_mesh = true
#    to_boundaries = '244'
#    from_blocks = 'pipe_44'
#    search_value_conflicts = false
#  []
#  [h_wall_from_sub]
#    type = MultiAppGeneralFieldNearestLocationTransfer
#    from_multi_app = sub
#    source_variable = heat_transfer_coefficient
#    variable = h_wall
#    displaced_source_mesh = true
#    search_value_conflicts = false
#  []
#[]

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
  [total_heat]
    type = ElmIntegTotFissHeatPostprocessor
    block = '10 11 15'
    execute_on = linear
  []
  [graphite_volume]
    type = VolumePostprocessor
    block = '0 1 2'
    execute_on = initial
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
  [out]
    type = Exodus
    execute_on = 'initial timestep_end'
    discontinuous = true
  []
[]
