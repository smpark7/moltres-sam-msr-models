[GlobalParams]
  num_groups = 2
  num_precursor_groups = 6
  use_exp_form = false
  group_fluxes = 'group1 group2'
  sss2_input = true
  account_delayed = false
  temperature = 900
[]

[Problem]
  type = EigenProblem
  bx_norm = bnorm
[]

[Mesh]
#  parallel_type = distributed
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
#  pre_blocks = '10 11 15'
  create_temperature_var = false
  eigen = true
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
  []
[]

[UserObjects]
  [fine_solution]
    type = SolutionUserObject
    system_variables = 'group1 group2'
    mesh = nt_2_out_0001_mesh.xda
    es = nt_2_out_0001.xda
  []
[]

[Functions]
  [fine_group1]
    type = SolutionFunction
    solution = fine_solution
    from_variable = group1
  []
  [fine_group2]
    type = SolutionFunction
    solution = fine_solution
    from_variable = group2
  []
[]

[Executioner]
#  type = Transient
#  dt = 1e-3
#  end_time = 20
  type = Eigenvalue
  free_power_iterations = 2
  initial_eigenvalue = 1

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
  line_search = 'none'

#  nl_abs_tol = 1e-10
  nl_abs_tol = 1e-10
#  l_tol = 1e-3
  [Quadrature]
    order = EIGHTH
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
  [total_heat]
    type = ElmIntegTotFissHeatPostprocessor
    block = '10 11 15'
  []
  [group1_norm]
    type = ElementL2Norm
    variable = group1
    block = '0 1 2 10 11'
  []
  [group2_norm]
    type = ElementL2Norm
    variable = group2
    block = '0 1 2 10 11'
  []
  [group1_error]
    type = ElementL2Error
    variable = group1
    block = '0 1 2 10 11'
    function = fine_group1
  []
  [group2_error]
    type = ElementL2Error
    variable = group2
    block = '0 1 2 10 11'
    function = fine_group2
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
