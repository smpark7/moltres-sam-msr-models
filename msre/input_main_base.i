[Problem]
  solve = false
[]

[Mesh]
  type = GeneratedMesh
  dim = 1
[]

[Functions]
  [dt_func]
    type = ParsedFunction
    expression = 'if(t<10, 1, 2)'
  []
[]

[Executioner]
  type = Transient
  end_time = 100
  [TimeStepper]
    type = FunctionDT
    function = dt_func
  []
[]

[MultiApps]
  [moltres]
    type = FullSolveMultiApp
    app_type = MoltresApp
    library_path = '/work/10525/smpark3/ls6/projects/moltres/lib'
#    library_path = '/home/smpark/projects/moltres-sam/lib'
    positions = '0 0 0'
    input_files = 'input_moltres.i'
    execute_on = timestep_end
    keep_solution_during_restore = true
    keep_aux_solution_during_restore = true
  []
  [sam]
    type = TransientMultiApp
    app_type = SamApp
    positions = '0 0 0'
    input_files = 'input_sam.i'
    execute_on = timestep_begin
    max_procs_per_app = 128
  []
[]

[Transfers]
  [T_fluid_to_moltres_boundaries]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = temperature
    variable = T_wall_fluid
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_to_moltres_boundaries_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = temperature
    variable = T_wall_fluid
    displaced_source_mesh = true
    to_boundaries = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [T_fluid_to_moltres_block]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = temperature
    variable = temperature
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [T_fluid_to_moltres_block_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = temperature
    variable = temperature
    displaced_source_mesh = true
    to_blocks = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [T_plenum_to_moltres_block_plenum]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = temperature
    variable = temperature
    displaced_source_mesh = true
    to_blocks = '3 4 5 6'
    from_blocks = 'lower_plenum upper_plenum'
    search_value_conflicts = false
  []
  [h_wall_to_moltres]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = heat_transfer_coefficient
    variable = h_wall
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [h_wall_to_moltres_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = heat_transfer_coefficient
    variable = h_wall
    displaced_source_mesh = true
    to_boundaries = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [delayed_neutron_to_moltres]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = delayed_neutron_source
    variable = delayed_neutron_source
    displaced_source_mesh = true
    search_value_conflicts = false
  []
  [delayed_neutron_to_moltres_control_channel]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = delayed_neutron_source
    variable = delayed_neutron_source
    displaced_source_mesh = true
    to_blocks = '244'
    from_blocks = 'pipe_44'
    search_value_conflicts = false
  []
  [delayed_neutron_to_moltres_plenum]
    type = MultiAppGeneralFieldNearestLocationTransfer
    to_multi_app = moltres
    source_variable = delayed_neutron_source
    variable = delayed_neutron_source
    displaced_source_mesh = true
    to_blocks = '3 4 5 6'
    from_blocks = 'lower_plenum upper_plenum'
    search_value_conflicts = false
  []
  [heat_from_sam_lower_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sam
    source_user_object = heat_uo_lower_plenum
    variable = heat
    displaced_target_mesh = true
    to_blocks = lower_plenum
    search_value_conflicts = false
  []
  [heat_from_sam_upper_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sam
    source_user_object = heat_uo_upper_plenum
    variable = heat
    displaced_target_mesh = true
    to_blocks = upper_plenum
    search_value_conflicts = false
  []
  [neutron_source_from_sam_lower_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sam
    source_user_object = nt_source_uo_lower_plenum
    variable = neutron_source
    displaced_target_mesh = true
    to_blocks = lower_plenum
    search_value_conflicts = false
  []
  [neutron_source_from_sam_upper_plenum]
    type = MultiAppGeneralFieldUserObjectTransfer
    from_multi_app = sam
    source_user_object = nt_source_uo_upper_plenum
    variable = neutron_source
    displaced_target_mesh = true
    to_blocks = upper_plenum
    search_value_conflicts = false
  []
[]
