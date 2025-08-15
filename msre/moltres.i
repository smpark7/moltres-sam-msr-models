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
    file = 'nt_mesh_fine_base_in.e'
  []
[]

[Nt]
  family = LAGRANGE
  order = SECOND
  var_name_base = group
  fission_blocks = '3 4 15'
  pre_blocks = '3 4 15'
  create_temperature_var = false
  eigen = true
[]

[Kernels]
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
  []
  [salt]
    type = MoltresJsonMaterial
    base_file = 'xsdata/xsdata-meter.json'
    material_key = 'fuel'
    block = '3 4 15'
    interp_type = 'none'
    prop_names = 'k cp rho'
    prop_values = '10.1 2386 2327.5'
  []
[]

[Executioner]
  type = Eigenvalue
  free_power_iterations = 4
  initial_eigenvalue = 0.6

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
  line_search = 'none'

#  nl_rel_tol = 1e-9
  nl_abs_tol = 1e-12
[]

[Postprocessors]
  [bnorm]
    type = ElmIntegTotFissNtsPostprocessor
    block = '3 4 15'
    execute_on = linear
  []
  [eigenvalue]
    type = VectorPostprocessorComponent
    vectorpostprocessor = eigenvalues
    vector_name = eigen_values_real
    index = 0
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
  []
[]
