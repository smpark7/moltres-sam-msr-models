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
    file = 'nt_mesh_fine_base_in.e'
  []
[]

[Nt]
  family = LAGRANGE
  order = SECOND
  var_name_base = group
#  vacuum_boundaries = 'left top bottom right'
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
[]

[Executioner]
##  type = Transient
##  dt = 1e-3
##  end_time = 20
#  type = Eigenvalue
#  free_power_iterations = 2
#  initial_eigenvalue = 1
#
#  solve_type = 'PJFNK'
##  solve_type = 'JACOBI_DAVIDSON'
#  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart'
#  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200'
##  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_agg_nl -pc_hypre_boomeramg_agg_num_paths -pc_hypre_boomeramg_max_levels -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type -pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -ksp_gmres_restart -pc_hypre_boomeramg_nfunctions'
##  petsc_options_value = 'hypre boomeramg 0.7 4 5 25 HMIS ext+i 2 0.3 200 2'
##  n_eigen_pairs = 1
##  n_basis_vectors = 20    # MOOSE mapping to SLEPc initial subspace (choose <= eps_mpd)
##  petsc_options_iname = '-eps_mpd -eps_jd_restart -eps_nev -eps_tol -eps_max_it -st_pc_type -st_pc_hypre_type' # -st_pc_hypre_boomeramg_nfunctions -st_ksp_type -st_ksp_rtol -st_ksp_max_it'
##  petsc_options_value = '20 0.7 1 1e-8 500 hypre boomeramg' # 2 gmres 1e-6 200'
##  petsc_options_iname = '-eps_mpd -eps_jd_restart -eps_nev'
##  petsc_options_value = '20 0.7 1'
##  line_search = 'none'
#
##  nl_abs_tol = 1e-10
#  nl_abs_tol = 1e-10
##  l_tol = 1e-3
  type = Eigenvalue
  eigen_problem_type = gen_non_hermitian
  which_eigen_pairs = SMALLEST_REAL
  n_eigen_pairs = 1
  n_basis_vectors = 20
  solve_type = jacobi_davidson
  petsc_options = '-eps_view'
  petsc_options_iname = '-eps_type -mat_shift_type -ksp_rtol'
  petsc_options_value = 'krylovshur nonzero 1e-6'
#  petsc_options_iname = '-eps_target -st_pc_type -st_pc_hypre_type -st_pc_hypre_boomeramg_nfunctions -st_pc_hypre_boomeramg_strong_threshold -st_pc_hypre_boomeramg_agg_nl -st_pc_hypre_boomeramg_agg_num_paths -st_pc_hypre_boomeramg_max_levels -st_pc_hypre_boomeramg_coarsen_type -st_pc_hypre_boomeramg_P_max -pc_hypre_boomeramg_truncfactor -st_ksp_gmres_restart -st_ksp_rtol -st_ksp_max_it -mat_shift_type'
#  petsc_options_value = '1.0 hypre boomeramg 2 0.7 4 5 25 HMIS 2 0.3 200 1e-6 200 nonzero'
[]

#[Preconditioning]
#  [smp]
#    type = SMP
#    full = true
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
[]

[VectorPostprocessors]
  [eigenvalues]
    type = Eigenvalues
    inverse_eigenvalue = true
#    outputs = console
  []
[]

[Outputs]
  perf_graph = true
  csv = true
  xda = true
  [console]
    type = Console
  []
  [out]
    type = Exodus
    execute_on = 'initial timestep_end'
    discontinuous = true
  []
[]
