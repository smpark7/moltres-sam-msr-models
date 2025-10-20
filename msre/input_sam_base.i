[GlobalParams]
  global_init_P = 1.0e5
  global_init_V = 0.25
  global_init_T = 900
  scaling_factor_var = '1 1e-3 1e-6'
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
    expression = 'if(t<10, 1, 2)'
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
  type = Transient
  end_time = 100

  steady_state_detection = true
  steady_state_start_time = 10

  petsc_options_iname = '-ksp_gmres_restart'
  petsc_options_value = '100'

  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8
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
  [TimeStepper]
    type = FunctionDT
    function = dt_func
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
