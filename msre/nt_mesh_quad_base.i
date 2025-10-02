# pitch = 5.08
radius = 0.508e-2
inch = 2.54e-2
# ratio = 1.016

[Mesh]
  # Unit cell
  [circle_cell]
    type = CartesianConcentricCircleAdaptiveBoundaryMeshGenerator
    num_sectors_per_side = '4 4 4 4'
    ring_radii = '${radius}'
    ring_intervals = '1'
    ring_block_ids = '11'
    background_intervals = '2'
    square_size = '${fparse inch * sqrt(2 * (0.6 ^ 2))}'
    preserve_volumes = true
    quad_element_type = QUAD8
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
    ix = '2 2 2'
    iy = '2'
    subdomain_id = '0 10 0'
  []
  [second_order]
    type = ElementOrderConversionGenerator
    input = center
    conversion_type = SECOND_ORDER_NONFULL
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
    background_intervals = 2
    polygon_size = ${fparse inch * 0.4}
    quad_element_type = QUAD8
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
  [new_bounds_1]
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
  [pattern]
    type = PatternedMeshGenerator
    inputs = 'new_bounds_1 new_bounds_2'
    pattern = '0 1 0 1 0 1 0 1 0 1;
               1 0 1 0 1 0 1 0 1 0;
               0 1 0 1 0 1 0 1 0 1;
               1 0 1 0 1 0 1 0 1 0;
               0 1 0 1 0 1 0 1 0 1;
               1 0 1 0 1 0 1 0 1 0;
               0 1 0 1 0 1 0 1 0 1;
               1 0 1 0 1 0 1 0 1 0;
               0 1 0 1 0 1 0 1 0 1;
               1 0 1 0 1 0 1 0 1 0'
    x_width = '${fparse sqrt(2) * inch}'
    y_width = '${fparse sqrt(2) * inch}'
  []
  [translate_mesh]
    type = TransformGenerator
    input = pattern
    transform = TRANSLATE_CENTER_ORIGIN
  []
  # Add control channel
  [highlight_center]
    type = SubdomainBoundingBoxGenerator
    input = translate_mesh
    block_id = 3
    restricted_subdomains = '11'
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
    top_right= '${fparse sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
  []
  [highlight_center_2]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center
    block_id = 3
    restricted_subdomains = '1'
    bottom_left = '${fparse -inch} ${fparse -inch} 0'
    top_right= '${fparse inch} ${fparse inch} 0'
  []
  [highlight_center_3]
    type = SubdomainBoundingBoxGenerator
    input = highlight_center_2
    block_id = 4
    restricted_subdomains = '2 10'
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -sqrt(2) * inch} 0'
    top_right= '${fparse sqrt(2) * inch} ${fparse sqrt(2) * inch} 0'
  []
  [delete_center]
    type = BlockDeletionGenerator
    input = highlight_center_3
    block = '3 4'
    new_boundary = 1001
  []
  [first_order]
    type = ElementOrderConversionGenerator
    input = delete_center
    conversion_type = FIRST_ORDER
  []
  [left_half_1]
    type = PlaneDeletionGenerator
    input = first_order
    point = '0 0 0'
    normal = '1 0 0'
  []
  [right_half_1]
    type = PlaneDeletionGenerator
    input = first_order
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [control_cell]
    type = CartesianConcentricCircleAdaptiveBoundaryMeshGenerator
    num_sectors_per_side = '12 12 12 12'
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
  [left_half_2]
    type = PlaneDeletionGenerator
    input = delete_background
    point = '0 0 0'
    normal = '1 0 0'
  []
  [right_half_2]
    type = PlaneDeletionGenerator
    input = delete_background
    point = '0 0 0'
    normal = '-1 0 0'
  []
  [fill_left]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = left_half_1
    input_mesh_2 = left_half_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [fill_right]
    type = FillBetweenSidesetsGenerator
    input_mesh_1 = right_half_1
    input_mesh_2 = right_half_2
    boundary_1 = 1001
    boundary_2 = 5
    num_layers = 2
    keep_inputs = false
    use_quad_elements = true
  []
  [stitch_2]
    type = StitchedMeshGenerator
    inputs = 'fill_left delete_background'
    stitch_boundaries_pairs = '10000 1000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_2]
    type = RenameBoundaryGenerator
    input = stitch_2
    old_boundary = '1000'
    new_boundary = '10000'
  []
  [stitch_3]
    type = StitchedMeshGenerator
    inputs = 'rename_boundary_2 fill_right'
    stitch_boundaries_pairs = '10000 10000'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
  [rename_boundary_3]
    type = RenameBoundaryGenerator
    input = stitch_3
    old_boundary = '10001'
    new_boundary = '10000'
  []
  [rename_block]
    type = RenameBlockGenerator
    input = rename_boundary_3
    old_block = '1'
    new_block = '0'
  []
  [second_order_2]
    type = ElementOrderConversionGenerator
    input = rename_block
    conversion_type = SECOND_ORDER_NONFULL
  []
  [stitch_4]
    type = StitchedMeshGenerator
    inputs = 'second_order_2 delete_center'
    stitch_boundaries_pairs = '10000 1001'
    clear_stitched_boundary_ids = true
    verbose_stitching = true
  []
#  # Rename salt blocks
#  [rename_fuel]
#    type = RenameBlockGenerator
#    input = stitch_4
#    old_block = '10 11'
#    new_block = '3 4'
#  []
  [remove_thimble]
    type = BlockDeletionGenerator
    input = stitch_4
    block = '13 14'
  []
  # Extrude to 3D
  [extrude]
    type = AdvancedExtruderGenerator
    input = remove_thimble
    heights = '1.70027'
    num_layers = '10'
    direction = '0 0 1'
#    bottom_boundary = 5
#    top_boundary = 6
  []
#  [transform_up]
#    type = TransformGenerator
#    input = extrude
#    transform = TRANSLATE
#    vector_value = '0 0 0.1875'
#  []
  [graphite_bounds]
    type = SideSetsBetweenSubdomainsGenerator
    input = extrude
    new_boundary = 100
    primary_block = '0 2'
    paired_block = '10 11 15'
  []
  [cleanup]
    type = RenameBoundaryGenerator
    input = graphite_bounds
    old_boundary = 5
    new_boundary = 101
  []
[]
