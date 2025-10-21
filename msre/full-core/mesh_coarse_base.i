# pitch = 5.08
radius = 0.508e-2
inch = 2.54e-2
lower_plenum_height = 0.1875
core_height = 1.70027
# ratio = 1.016

[Mesh]
  # Unit cell
  [circle_cell]
    type = CartesianConcentricCircleAdaptiveBoundaryMeshGenerator
    num_sectors_per_side = '4 4 4 4'
    ring_radii = '${radius}'
    ring_intervals = '1'
    ring_block_ids = '11'
    background_intervals = '1'
    square_size = '${fparse inch * sqrt(2 * (0.6 ^ 2))}'
    preserve_volumes = true
    quad_element_type = QUAD9
    tri_element_type = TRI6
  []
  [top_right]
    type = PlaneDeletionGenerator
    input = circle_cell
    point = '0 0 0'
    normal = '-1 -1 0'
    new_boundary = 1
  []
  [translate_tr]
    type = TransformGenerator
    input = top_right
    transform = TRANSLATE
    vector_value = '${fparse inch * sqrt((0.4 ^ 2) / 2)} ${fparse inch * sqrt((0.4 ^ 2) / 2)} 0'
  []
  [bottom_left]
    type = PlaneDeletionGenerator
    input = circle_cell
    point = '0 0 0'
    normal = '1 1 0'
    new_boundary = 1
  []
  [translate_bl]
    type = TransformGenerator
    input = bottom_left
    transform = TRANSLATE
    vector_value = '${fparse -inch * sqrt((0.4 ^ 2) / 2)} ${fparse -inch * sqrt((0.4 ^ 2) / 2)} 0'
  []
  [center]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${fparse 0.4 * inch} ${fparse 0.4 * inch} ${fparse 0.4 * inch}'
    dy = '${fparse 0.8 * inch}'
    ix = '1 2 1'
    iy = '2'
    subdomain_id = '0 10 0'
  []
  [second_order]
    type = ElementOrderConversionGenerator
    input = center
    conversion_type = SECOND_ORDER
  []
  [rename_boundary]
    type = RenameBoundaryGenerator
    input = second_order
    old_boundary = '0 1 2 3'
    new_boundary = '10 11 12 13'
  []
  [center_center]
    type = TransformGenerator
    input = rename_boundary
    transform = TRANSLATE_CENTER_ORIGIN
  []
  [rotate_center]
    type = TransformGenerator
    input = center_center
    transform = ROTATE
    vector_value = '-45 0 0'
  []
  [square_cell]
    type = PolygonConcentricCircleMeshGenerator
    num_sides = 4
    num_sectors_per_side = '2 2 2 2'
    background_intervals = 1
    polygon_size = ${fparse inch * 0.4}
    quad_element_type = QUAD9
    tri_element_type = TRI6
  []
  [top]
    type = PlaneDeletionGenerator
    input = square_cell
    point = '0 0 0'
    normal = '0 1 0'
  []
  [top_left]
    type = PlaneDeletionGenerator
    input = top
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [translate_tl]
    type = TransformGenerator
    input = top_left
    transform = TRANSLATE
    vector_value = '${fparse -inch / sqrt(2)} ${fparse inch / sqrt(2)} 0'
  []
  [bottom]
    type = PlaneDeletionGenerator
    input = square_cell
    point = '0 0 0'
    normal = '0 -1 0'
  []
  [bottom_right]
    type = PlaneDeletionGenerator
    input = bottom
    point = '0 0 0'
    normal = '1 0 0'
  []
  [translate_br]
    type = TransformGenerator
    input = bottom_right
    transform = TRANSLATE
    vector_value = '${fparse inch / sqrt(2)} ${fparse -inch / sqrt(2)} 0'
  []
  [stitch]
    type = StitchedMeshGenerator
    inputs = 'rotate_center translate_tr translate_bl translate_tl translate_br'
    stitch_boundaries_pairs = '12 1; 10 1; 13 10000; 11 10000'
    clear_stitched_boundary_ids = false
    verbose_stitching = true
  []
  [rename_blocks]
    type = RenameBlockGenerator
    input = stitch
    old_block = '0'
    new_block = '2'
  []
  [delete_bounds]
    type = BoundaryDeletionGenerator
    input = rename_blocks
    boundary_names = '1 10 11 12 13 10000 10002 10003 10004 10006'
  []
  [fuel_bounds]
    type = SideSetsBetweenSubdomainsGenerator
    input = delete_bounds
    new_boundary = 101
    paired_block = '10 11'
    primary_block = '2'
  []
  [new_bounds]
    type = SideSetsFromNormalsGenerator
    input = fuel_bounds
    new_boundary = 'left top right bottom'
    normals = '-1 0 0 0 1 0 1 0 0 0 -1 0'
    fixed_normal = true
  []
  # Rotated unit cell
  [rotate_cell]
    type = TransformGenerator
    input = fuel_bounds
    transform = ROTATE
    vector_value = '90 0 0'
  []
  [new_bounds_2]
    type = SideSetsFromNormalsGenerator
    input = rotate_cell
    new_boundary = 'left top right bottom'
    normals = '-1 0 0 0 1 0 1 0 0 0 -1 0'
    fixed_normal = true
  []
  # Lattice
  [dummy]
    type = RenameBlockGenerator
    input = new_bounds
    old_block = '1 2 10 11'
    new_block = '100 101 101 100'
  []
  [dummy_2]
    type = RenameBlockGenerator
    input = new_bounds_2
    old_block = '1 2 10 11'
    new_block = '100 101 101 100'
  []
  [pattern]
    type = PatternedMeshGenerator
    inputs = 'new_bounds new_bounds_2 dummy_2 dummy'
    pattern = '3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2;
               2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3;
               3 2 3 2 3 2 3 2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3 2 3 2 3 2 3 2;
               2 3 2 3 2 3 2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3 2 3 2 3 2 3;
               3 2 3 2 3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2 3 2 3 2;
               2 3 2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3 2 3;
               3 2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3 2;
               2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3;
               3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2;
               2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3;
               3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2;
               2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3;
               3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2;
               2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3;
               3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2;
               2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3;
               3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2;
               2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3;
               3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2;
               2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3;
               3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2;
               2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3;
               3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2;
               2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3;
               3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2;
               2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3;
               3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2;
               2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3;
               3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2;
               2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3;
               3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2;
               2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3;
               3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2;
               2 3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2 3;
               3 2 3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2 3 2;
               2 3 2 3 2 3 2 3 2 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 3 2 3 2 3 2 3 2 3;
               3 2 3 2 3 2 3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2 3 2 3 2 3 2;
               2 3 2 3 2 3 2 3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2 3 2 3 2 3 2 3;
               3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 1 0 1 0 1 0 1 0 1 0 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2;
               2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3'
    x_width = '${fparse sqrt(2) * inch}'
    y_width = '${fparse sqrt(2) * inch}'
  []
  [translate_mesh]
    type = TransformGenerator
    input = pattern
    transform = TRANSLATE_CENTER_ORIGIN
  []
  # Control channel 1
  [highlight_center_1_1]
    type = SubdomainBoundingBoxGenerator
    input = translate_mesh
    block_id = 3
    restricted_subdomains = '11'
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
    top_right= '${fparse sqrt(2) * inch} ${fparse 3 * sqrt(2) * inch} 0'
  []
  [highlight_center_1_2]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_1_1
    block_id = 3
    restricted_subdomains = '1'
    bottom_left = '${fparse -inch} ${fparse (2 * sqrt(2) - 1) * inch} 0'
    top_right= '${fparse inch} ${fparse (2 * sqrt(2) + 1) * inch} 0'
  []
  [highlight_center_1_3]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_1_2
    block_id = 4
    restricted_subdomains = '2 10'
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
    top_right= '${fparse sqrt(2) * inch} ${fparse 3 * sqrt(2) * inch} 0'
  []
  [delete_center_1]
    type = BlockDeletionGenerator
    input = highlight_center_1_3
    block = '3 4'
    new_boundary = 1001
  []
  [first_order_1]
    type = ElementOrderConversionGenerator
    input = delete_center_1
    conversion_type = FIRST_ORDER
  []
  [left_half_1_1]
    type = PlaneDeletionGenerator
    input = first_order_1
    point = '0 0 0'
    normal = '1 0 0'
  []
  [right_half_1_1]
    type = PlaneDeletionGenerator
    input = first_order_1
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [control_cell]
    type = CartesianConcentricCircleAdaptiveBoundaryMeshGenerator
    num_sectors_per_side = '10 10 10 10'
    ring_radii = '${fparse inch-0.1651e-2} ${inch} 3.1992e-2'
    ring_intervals = '1 1 2'
    ring_block_ids = '13 14 15'
    background_intervals = '1'
    square_size = '${fparse inch * sqrt(2) * 2}'
    preserve_volumes = true
    quad_element_type = QUAD4
    tri_element_type = TRI3
  []
  [delete_background]
    type = BlockDeletionGenerator
    input = control_cell
    block = 4
    new_boundary = 1000
  []
  [translate_control_1]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '0 ${fparse 2 * sqrt(2) * inch} 0'
  []
  [left_half_1_2]
    type = PlaneDeletionGenerator
    input = translate_control_1
    point = '0 0 0'
    normal = '1 0 0'
  []
  [right_half_1_2]
    type = PlaneDeletionGenerator
    input = translate_control_1
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [fill_left_1]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = left_half_1_1
    input_mesh_2 = left_half_1_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [fill_right_1]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = right_half_1_1
    input_mesh_2 = right_half_1_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [stitch_1_1]
    type = StitchedMeshGenerator
    inputs = 'fill_left_1 translate_control_1'
    stitch_boundaries_pairs = '10000 1000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_1_1]
    type = RenameBoundaryGenerator
    input = stitch_1_1
    old_boundary = '1000'
    new_boundary = '10000'
  []
  [stitch_1_2]
    type = StitchedMeshGenerator
    inputs = 'rename_boundary_1_1 fill_right_1'
    stitch_boundaries_pairs = '10000 10000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_1_2]
    type = RenameBoundaryGenerator
    input = stitch_1_2
    old_boundary = '10001'
    new_boundary = '10000'
  []
  [rename_block_1]
    type = RenameBlockGenerator
    input = rename_boundary_1_2
    old_block = '1'
    new_block = '0'
  []
  [second_order_2]
    type = ElementOrderConversionGenerator
    input = rename_block_1
    conversion_type = SECOND_ORDER
  []
  [stitch_1_3]
    type = StitchedMeshGenerator
    inputs = 'second_order_2 delete_center_1'
    stitch_boundaries_pairs = '10000 1001'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  # Control channel 2
  [highlight_center_2_1]
    type = SubdomainBoundingBoxGenerator
    input = stitch_1_3
    block_id = 3
    restricted_subdomains = '11'
    bottom_left = '${fparse -3 * sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
    top_right= '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
  []
  [highlight_center_2_2]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_2_1
    block_id = 3
    restricted_subdomains = '1'
    bottom_left = '${fparse -(2 * sqrt(2) + 1) * inch} ${fparse -inch} 0'
    top_right= '${fparse -(2 * sqrt(2) - 1) * inch} ${fparse inch} 0'
  []
  [highlight_center_2_3]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_2_2
    block_id = 4
    restricted_subdomains = '2 10'
    bottom_left = '${fparse -3 * sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
    top_right= '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
  []
  [delete_center_2]
    type = BlockDeletionGenerator
    input = highlight_center_2_3
    block = '3 4'
    new_boundary = 1001
  []
  [first_order_2]
    type = ElementOrderConversionGenerator
    input = delete_center_2
    conversion_type = FIRST_ORDER
  []
  [left_half_2_1]
    type = PlaneDeletionGenerator
    input = first_order_2
    point = '${fparse -2 * sqrt(2) * inch} 0 0'
    normal = '1 0 0'
  []
  [right_half_2_1]
    type = PlaneDeletionGenerator
    input = first_order_2
    point = '${fparse -2 * sqrt(2) * inch} 0 0'
    normal = '-1 0 0'
  []
  [translate_control_2]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '${fparse -2 * sqrt(2) * inch} 0 0'
  []
  [left_half_2_2]
    type = PlaneDeletionGenerator
    input = translate_control_2
    point = '${fparse -2 * sqrt(2) * inch} 0 0'
    normal = '1 0 0'
  []
  [right_half_2_2]
    type = PlaneDeletionGenerator
    input = translate_control_2
    point = '${fparse -2 * sqrt(2) * inch} 0 0'
    normal = '-1 0 0'
  []
  [fill_left_2]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = left_half_2_1
    input_mesh_2 = left_half_2_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [fill_right_2]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = right_half_2_1
    input_mesh_2 = right_half_2_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [stitch_2_1]
    type = StitchedMeshGenerator
    inputs = 'fill_left_2 translate_control_2'
    stitch_boundaries_pairs = '10000 1000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_2_1]
    type = RenameBoundaryGenerator
    input = stitch_2_1
    old_boundary = '1000'
    new_boundary = '10000'
  []
  [stitch_2_2]
    type = StitchedMeshGenerator
    inputs = 'rename_boundary_2_1 fill_right_2'
    stitch_boundaries_pairs = '10000 10000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_2_2]
    type = RenameBoundaryGenerator
    input = stitch_2_2
    old_boundary = '10001'
    new_boundary = '10000'
  []
  [rename_block_2]
    type = RenameBlockGenerator
    input = rename_boundary_2_2
    old_block = '1'
    new_block = '0'
  []
  [second_order_3]
    type = ElementOrderConversionGenerator
    input = rename_block_2
    conversion_type = SECOND_ORDER
  []
  [stitch_2_3]
    type = StitchedMeshGenerator
    inputs = 'second_order_3 delete_center_2'
    stitch_boundaries_pairs = '10000 1001'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
    prevent_boundary_ids_overlap = false
  []
  # Control channel 3
  [highlight_center_3_1]
    type = SubdomainBoundingBoxGenerator
    input = stitch_2_3
    block_id = 3
    restricted_subdomains = '11'
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -3 * sqrt(2) * inch} 0'
    top_right= '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
  []
  [highlight_center_3_2]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_3_1
    block_id = 3
    restricted_subdomains = '1'
    bottom_left = '${fparse -inch} ${fparse -(2 * sqrt(2) + 1) * inch} 0'
    top_right= '${fparse inch} ${fparse -(2 * sqrt(2) - 1) * inch} 0'
  []
  [highlight_center_3_3]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_3_2
    block_id = 4
    restricted_subdomains = '2 10'
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -3 * sqrt(2) * inch} 0'
    top_right= '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
  []
  [delete_center_3]
    type = BlockDeletionGenerator
    input = highlight_center_3_3
    block = '3 4'
    new_boundary = 1001
  []
  [first_order_3]
    type = ElementOrderConversionGenerator
    input = delete_center_3
    conversion_type = FIRST_ORDER
  []
  [left_half_3_1]
    type = PlaneDeletionGenerator
    input = first_order_3
    point = '0 0 0'
    normal = '1 0 0'
  []
  [right_half_3_1]
    type = PlaneDeletionGenerator
    input = first_order_3
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [translate_control_3]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '0 ${fparse -2 * sqrt(2) * inch} 0'
  []
  [left_half_3_2]
    type = PlaneDeletionGenerator
    input = translate_control_3
    point = '0 0 0'
    normal = '1 0 0'
  []
  [right_half_3_2]
    type = PlaneDeletionGenerator
    input = translate_control_3
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [fill_left_3]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = left_half_3_1
    input_mesh_2 = left_half_3_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [fill_right_3]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = right_half_3_1
    input_mesh_2 = right_half_3_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [stitch_3_1]
    type = StitchedMeshGenerator
    inputs = 'fill_left_3 translate_control_3'
    stitch_boundaries_pairs = '10000 1000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_3_1]
    type = RenameBoundaryGenerator
    input = stitch_3_1
    old_boundary = '1000'
    new_boundary = '10000'
  []
  [stitch_3_2]
    type = StitchedMeshGenerator
    inputs = 'rename_boundary_3_1 fill_right_3'
    stitch_boundaries_pairs = '10000 10000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_3_2]
    type = RenameBoundaryGenerator
    input = stitch_3_2
    old_boundary = '10001'
    new_boundary = '10000'
  []
  [rename_block_3]
    type = RenameBlockGenerator
    input = rename_boundary_3_2
    old_block = '1'
    new_block = '0'
  []
  [second_order_4]
    type = ElementOrderConversionGenerator
    input = rename_block_3
    conversion_type = SECOND_ORDER
  []
  [stitch_3_3]
    type = StitchedMeshGenerator
    inputs = 'second_order_4 delete_center_3'
    stitch_boundaries_pairs = '10000 1001'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
    prevent_boundary_ids_overlap = false
  []
  # Control channel 4
  [highlight_center_4_1]
    type = SubdomainBoundingBoxGenerator
    input = stitch_3_3
    block_id = 3
    restricted_subdomains = '11'
    bottom_left = '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
    top_right= '${fparse 3 * sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
  []
  [highlight_center_4_2]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_4_1
    block_id = 3
    restricted_subdomains = '1'
    bottom_left = '${fparse (2 * sqrt(2) - 1) * inch} ${fparse -inch} 0'
    top_right= '${fparse (2 * sqrt(2) + 1) * inch} ${fparse inch} 0'
  []
  [highlight_center_4_3]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_4_2
    block_id = 4
    restricted_subdomains = '2 10'
    bottom_left = '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
    top_right= '${fparse 3 * sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
  []
  [delete_center_4]
    type = BlockDeletionGenerator
    input = highlight_center_4_3
    block = '3 4'
    new_boundary = 1001
  []
  [first_order_4]
    type = ElementOrderConversionGenerator
    input = delete_center_4
    conversion_type = FIRST_ORDER
  []
  [left_half_4_1]
    type = PlaneDeletionGenerator
    input = first_order_4
    point = '${fparse 2 * sqrt(2) * inch} 0 0'
    normal = '1 0 0'
  []
  [right_half_4_1]
    type = PlaneDeletionGenerator
    input = first_order_4
    point = '${fparse 2 * sqrt(2) * inch} 0 0'
    normal = '-1 0 0'
  []
  [translate_control_4]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '${fparse 2 * sqrt(2) * inch} 0 0'
  []
  [left_half_4_2]
    type = PlaneDeletionGenerator
    input = translate_control_4
    point = '${fparse 2 * sqrt(2) * inch} 0 0'
    normal = '1 0 0'
  []
  [right_half_4_2]
    type = PlaneDeletionGenerator
    input = translate_control_4
    point = '${fparse 2 * sqrt(2) * inch} 0 0'
    normal = '-1 0 0'
  []
  [fill_left_4]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = left_half_4_1
    input_mesh_2 = left_half_4_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [fill_right_4]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = right_half_4_1
    input_mesh_2 = right_half_4_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [stitch_4_1]
    type = StitchedMeshGenerator
    inputs = 'fill_left_4 translate_control_4'
    stitch_boundaries_pairs = '10000 1000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_4_1]
    type = RenameBoundaryGenerator
    input = stitch_4_1
    old_boundary = '1000'
    new_boundary = '10000'
  []
  [stitch_4_2]
    type = StitchedMeshGenerator
    inputs = 'rename_boundary_4_1 fill_right_4'
    stitch_boundaries_pairs = '10000 10000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_4_2]
    type = RenameBoundaryGenerator
    input = stitch_4_2
    old_boundary = '10001'
    new_boundary = '10000'
  []
  [rename_block_4]
    type = RenameBlockGenerator
    input = rename_boundary_4_2
    old_block = '1'
    new_block = '0'
  []
  [second_order_5]
    type = ElementOrderConversionGenerator
    input = rename_block_4
    conversion_type = SECOND_ORDER
  []
  [stitch_4_3]
    type = StitchedMeshGenerator
    inputs = 'second_order_5 delete_center_4'
    stitch_boundaries_pairs = '10000 1001'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
    prevent_boundary_ids_overlap = false
  []
  [remove_thimble]
    type = BlockDeletionGenerator
    input = stitch_4_3
    block = '13 14'
  []
  # Remove dummy blocks
  [delete_dummy]
    type = BlockDeletionGenerator
    input = remove_thimble
    block = '100 101'
    new_boundary = 102
  []
  [trim_1]
    type = ParsedElementDeletionGenerator
    input = delete_dummy
    expression = '((x^2 + y^2) > 0.7^2)'
    new_boundary = 102
  []
  [highlight_edge_1]
    type = SubdomainBoundingBoxGenerator
    input = trim_1
    bottom_left = '${fparse 18.5 * sqrt(2) * inch} ${fparse 4.5 * sqrt(2) * inch} 0'
    top_right = '${fparse 19.5 * sqrt(2) * inch} ${fparse 5.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_2]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_1
    bottom_left = '${fparse 4.5 * sqrt(2) * inch} ${fparse 18.5 * sqrt(2) * inch} 0'
    top_right = '${fparse 5.5 * sqrt(2) * inch} ${fparse 19.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_3]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_2
    bottom_left = '${fparse -5.5 * sqrt(2) * inch} ${fparse 18.5 * sqrt(2) * inch} 0'
    top_right = '${fparse -4.5 * sqrt(2) * inch} ${fparse 19.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_4]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_3
    bottom_left = '${fparse -19.5 * sqrt(2) * inch} ${fparse 4.5 * sqrt(2) * inch} 0'
    top_right = '${fparse -18.5 * sqrt(2) * inch} ${fparse 5.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_5]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_4
    bottom_left = '${fparse -19.5 * sqrt(2) * inch} ${fparse -5.5 * sqrt(2) * inch} 0'
    top_right = '${fparse -18.5 * sqrt(2) * inch} ${fparse -4.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_6]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_5
    bottom_left = '${fparse -5.5 * sqrt(2) * inch} ${fparse -19.5 * sqrt(2) * inch} 0'
    top_right = '${fparse -4.5 * sqrt(2) * inch} ${fparse -18.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_7]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_6
    bottom_left = '${fparse 4.5 * sqrt(2) * inch} ${fparse -19.5 * sqrt(2) * inch} 0'
    top_right = '${fparse 5.5 * sqrt(2) * inch} ${fparse -18.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [highlight_edge_8]
    type = SubdomainBoundingBoxGenerator
    input = highlight_edge_7
    bottom_left = '${fparse 18.5 * sqrt(2) * inch} ${fparse -5.5 * sqrt(2) * inch} 0'
    top_right = '${fparse 19.5 * sqrt(2) * inch} ${fparse -4.5 * sqrt(2) * inch} 0'
    block_id = 100
    restricted_subdomains = 1
  []
  [trim_2]
    type = BlockDeletionGenerator
    input = highlight_edge_8
    block = 100
    new_boundary = 102
  []
#  [rotate_45]
#    type = TransformGenerator
#    input = delete_dummy
#    transform = ROTATE
#    vector_value = '-45 0 0'
#  []
  [ring_graphite]
    type = PeripheralRingMeshGenerator
    input = trim_2
    external_boundary_id = 103
    peripheral_ring_radius = 0.71120
    peripheral_layer_num = 2
    input_mesh_external_boundary = 102
    peripheral_ring_block_id = 2
  []
  [ring_reflector]
    type = PeripheralRingMeshGenerator
    input = ring_graphite
    peripheral_layer_num = 2
    peripheral_ring_radius = 0.7366
    input_mesh_external_boundary = 103
    peripheral_ring_block_id = 7
    external_boundary_id = 104
  []
  [delete_bounds_2]
    type = BoundaryDeletionGenerator
    input = ring_reflector
    boundary_names = '10000'
  []
  # Extrude to 3D
  [extrude]
    type = AdvancedExtruderGenerator
    input = delete_bounds_2
    heights = '0.1875 1.70027 0.254'
    num_layers = '1 3 1'
    direction = '0 0 1'
#    bottom_boundary = 5
#    top_boundary = 6
    subdomain_swaps = '0 3 1 4 2 3 10 3 11 4 15 3; ; 0 5 1 6 2 5 10 5 11 6 15 5'
  []
  [graphite_bounds]
    type = SideSetsBetweenSubdomainsGenerator
    input = extrude
    new_boundary = 100
    primary_block = '0 2'
    paired_block = '10 11 15'
  []
  [cleanup]
    type = BoundaryDeletionGenerator
    input = graphite_bounds
    boundary_names = '5 101 102 103'
  []
  [control_channel_bound_1]
    type = SideSetsFromBoundingBoxGenerator
    input = cleanup
    boundary_new = 30000
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse sqrt(2) * inch} ${fparse 3 * sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 100
  []
  [control_channel_bound_2]
    type = SideSetsFromBoundingBoxGenerator
    input = control_channel_bound_1
    boundary_new = 30001
    bottom_left = '${fparse -3 * sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 100
  []
  [control_channel_bound_3]
    type = SideSetsFromBoundingBoxGenerator
    input = control_channel_bound_2
    boundary_new = 30002
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -3 * sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 100
  []
  [control_channel_bound_4]
    type = SideSetsFromBoundingBoxGenerator
    input = control_channel_bound_3
    boundary_new = 30003
    bottom_left = '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse 3 * sqrt(2) * inch} ${fparse sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 100
  []
  [control_channel_block_1]
    type = SubdomainBoundingBoxGenerator
    input = control_channel_bound_4
    block_id = 30000
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse sqrt(2) * inch} ${fparse 3 * sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    restricted_subdomains = 15
  []
  [control_channel_block_2]
    type = SubdomainBoundingBoxGenerator
    input = control_channel_block_1
    block_id = 30001
    bottom_left = '${fparse -3 * sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    restricted_subdomains = 15
  []
  [control_channel_block_3]
    type = SubdomainBoundingBoxGenerator
    input = control_channel_block_2
    block_id = 30002
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -3 * sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    restricted_subdomains = 15
  []
  [control_channel_block_4]
    type = SubdomainBoundingBoxGenerator
    input = control_channel_block_3
    block_id = 30003
    bottom_left = '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse 3 * sqrt(2) * inch} ${fparse sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    restricted_subdomains = 15
  []
[]
