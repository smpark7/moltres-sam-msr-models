[GlobalParams]
  num_groups = 2
  num_precursor_groups = 0
  use_exp_form = false
  group_fluxes = 'group1 group2'
  pre_concs = ''
  sss2_input = true
  account_delayed = true
  temperature = temperature
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
  eigen = false
  eigenvalue_scaling = 1.461738
  nt_ic_function = nt_func
  delayed_neutron_source = delayed_neutron_source
#  scaling = 1e-17
[]

[Variables]
  [T_solid]
    family = LAGRANGE
    order = SECOND
    block = '0 1 2'
    initial_condition = 900
#    scaling = 1e-6
  []
[]

[AuxVariables]
  [temperature]
    family = MONOMIAL
    order = FIRST
    initial_condition = 900
  []
  [h_wall]
    family = LAGRANGE
    order = SECOND
    block = '0 2'
    initial_condition = 300
  []
  [T_fluid]
    family = LAGRANGE
    order = FIRST
    initial_condition = 900
  []
  [T_wall_fluid]
    family = LAGRANGE
    order = SECOND
    block = '0 2'
    initial_condition = 900
  []
  [T_plenum]
    family = LAGRANGE
    order = FIRST
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
  [time]
    type = MatINSTemperatureTimeDerivative
    variable = T_solid
    block = '0 1 2'
  []
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
    average_fission_heat = total_heat
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
  [temperature_plenum]
    type = ProjectionAux
    variable = temperature
    v = T_plenum
    block = '3 4 5 6'
  []
  [heat_source_fluid]
    type = FissionHeatSourceAux
    variable = heat
    tot_fission_heat = 1.0
    power = ${fparse (1 - 0.078) * 1e15}
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
    expression = '0.078 / volume * 1e15'
    symbol_names = 'volume'
    symbol_values = 'graphite_volume'
  []
  [nt_func]
    type = ParsedFunction
    expression = '1'
  []
  [dt_func]
    type = ParsedFunction
    expression = 'if(t<=1e-1, 1e-2, if(t<=5, 0.1, 0.5))'
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
    prop_values = '154.79 1758.46 1860'
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
    temperature = T_fluid
  []
  [plenum]
    type = MoltresJsonMaterial
    base_file = 'openmc/xs-data/msre_si.json'
    material_key = 'fuel'
    block = '3 4 5 6'
    interp_type = 'linear'
    prop_names = 'k cp rho'
    prop_values = '10.1 2386 2327.5'
    temperature = T_plenum
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
  type = Transient
#  dt = 1e-3
  end_time = 200

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
  line_search = 'none'

#  nl_abs_tol = 1e-10
  nl_abs_tol = 1e-6
  l_tol = 1e-3

  automatic_scaling = true
  compute_scaling_once = false
  resid_vs_jac_scaling_param = 0.1

  [TimeStepper]
    type = FunctionDT
    function = dt_func
  []
[]

[Postprocessors]
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
    hide = 'T_fluid T_plenum T_wall_fluid h_wall heat neutron_source'
  []
[]

[Debug]
  show_var_residual_norms = true
[]
