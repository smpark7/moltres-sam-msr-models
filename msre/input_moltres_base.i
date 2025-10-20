[GlobalParams]
  num_groups = 2
  num_precursor_groups = 0
  use_exp_form = false
  group_fluxes = 'group1 group2'
  pre_concs = ''
  sss2_input = true
  account_delayed = true
  temperature = temperature
  delayed_neutron_source = delayed_neutron_source
[]

[Problem]
  type = EigenProblem
  bx_norm = bnorm
[]

[Mesh]
  parallel_type = distributed
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
  []
[]

[AuxVariables]
  [temperature]
    family = MONOMIAL
    order = SECOND
    initial_condition = 900
  []
  [h_wall]
    family = LAGRANGE
    order = SECOND
    block = '0 2'
    initial_condition = 3e2
  []
  [T_wall_fluid]
    family = LAGRANGE
    order = SECOND
    block = '0 2'
    initial_condition = 900
  []
  [heat]
    family = MONOMIAL
    order = SECOND
  []
  [neutron_source]
    family = MONOMIAL
    order = SECOND
  []
  [delayed_neutron_source]
    family = MONOMIAL
    order = FIRST
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
  [nt_source]
    type = NeutronSourceAux
    variable = neutron_source
#    nt_scale = 1e-15
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
    base_file = 'openmc/xs-data/msre_si.json'
    material_key = 'fuel'
    block = '10 11 15'
    interp_type = 'linear'
    prop_names = 'k cp rho'
    prop_values = '10.1 2386 2327.5'
  []
  [plenum]
    type = MoltresJsonMaterial
    base_file = 'openmc/xs-data/msre_si.json'
    material_key = 'fuel'
    block = '3 4 5 6'
    interp_type = 'linear'
    prop_names = 'k cp rho'
    prop_values = '10.1 2386 2327.5'
  []
[]

[BCs]
  [wall]
    type = CoupledConvectiveHeatFluxBC
    variable = T_solid
    boundary = '100'
    htc = h_wall
    T_infinity = T_wall_fluid
  []
[]

[UserObjects]
  [heat_uo_lower_plenum]
    type = LayeredAverage
    variable = heat
    direction = z
    num_layers = 19
    block = '3 4'
    execute_on = 'initial timestep_end'
    sample_type = direct
  []
  [heat_uo_upper_plenum]
    type = LayeredAverage
    variable = heat
    direction = z
    num_layers = 25
    block = '5 6'
    execute_on = 'initial timestep_end'
    sample_type = direct
  []
  [nt_source_uo_lower_plenum]
    type = LayeredAverage
    variable = neutron_source
    direction = z
    num_layers = 19
    block = '3 4'
    execute_on = 'initial timestep_end'
    sample_type = direct
  []
  [nt_source_uo_upper_plenum]
    type = LayeredAverage
    variable = neutron_source
    direction = z
    num_layers = 25
    block = '5 6'
    execute_on = 'initial timestep_end'
    sample_type = direct
  []
[]

[Executioner]
  type = Eigenvalue
  free_power_iterations = 2
  initial_eigenvalue = 1
  normal_factor = '1'
  normalization = bnorm

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
  line_search = 'none'

  automatic_scaling = true
  compute_scaling_once = false
  resid_vs_jac_scaling_param = 0.1

  nl_abs_tol = 1e-8
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
