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
    ix = '1 2 1'
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
    background_intervals = 1
    polygon_size = ${fparse inch * 0.4}
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
  [new_bounds]
    type = SideSetsFromNormalsGenerator
    input = delete_bounds
    new_boundary = 'left top right bottom'
    normals = '-1 0 0 0 1 0 1 0 0 0 -1 0'
    fixed_normal = true
  []
  # Rotated unit cell
  [rotate_cell]
    type = TransformGenerator
    input = delete_bounds
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
  [line_block_1]
    type = LowerDBlockFromSidesetGenerator
    input = delete_center_1
    sidesets = 1001
    new_block_id = 1001
  []
  [isolate_line_1]
    type = BlockDeletionGenerator
    input = line_block_1
    block = '1 2 10 11 100 101'
    delete_exteriors = false
  []
  # Reduce to first order to avoid bug with XYDelaunay on EDGE3
  [first_order_1]
    type = ElementOrderConversionGenerator
    input = isolate_line_1
    conversion_type = FIRST_ORDER
  []
  [control_cell]
    type = CartesianConcentricCircleAdaptiveBoundaryMeshGenerator
    num_sectors_per_side = '8 8 8 8'
    ring_radii = '${fparse inch-0.1651e-2} ${inch} 3.1992e-2'
    ring_intervals = '1 1 1'
    ring_block_ids = '13 14 15'
    background_intervals = '1'
    square_size = '${fparse inch * sqrt(2) * 2}'
    preserve_volumes = true
    quad_element_type = QUAD8
    tri_element_type = TRI6
  []
  [delete_background]
    type = BlockDeletionGenerator
    input = control_cell
    block = 4
  []
  [translate_control_1]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '0 ${fparse 2 * sqrt(2) * inch} 0'
  []
  [xydelaunay_1]
    type = XYDelaunayGenerator
    boundary = first_order_1
    holes = translate_control_1
    stitch_holes = true
    refine_boundary = false
    refine_holes = false
    tri_element_type = TRI6
    hole_boundaries = 'ring'
  []
  [stitch_control_1]
    type = StitchedMeshGenerator
    inputs = 'delete_center_1 xydelaunay_1'
    stitch_boundaries_pairs = '1001 6'
    clear_stitched_boundary_ids = false
    verbose_stitching = true
  []
  [delete_bounds_1]
    type = BoundaryDeletionGenerator
    input = stitch_control_1
    boundary_names = '1001 1002 1003 1004 1005'
  []
  # Control channel 2
  [highlight_center_2_1]
    type = SubdomainBoundingBoxGenerator
    input = delete_bounds_1
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
  [line_block_2]
    type = LowerDBlockFromSidesetGenerator
    input = delete_center_2
    sidesets = 1001
    new_block_id = 1001
  []
  [isolate_line_2]
    type = BlockDeletionGenerator
    input = line_block_2
    block = '1 2 10 11 100 101 0 13 14 15'
    delete_exteriors = false
  []
  # Reduce to first order to avoid bug with XYDelaunay on EDGE3
  [first_order_2]
    type = ElementOrderConversionGenerator
    input = isolate_line_2
    conversion_type = FIRST_ORDER
  []
  [translate_control_2]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '${fparse -2 * sqrt(2) * inch} 0 0'
  []
  [xydelaunay_2]
    type = XYDelaunayGenerator
    boundary = first_order_2
    holes = translate_control_2
    stitch_holes = true
    refine_boundary = false
    refine_holes = false
    tri_element_type = TRI6
    hole_boundaries = 'ring'
  []
  [stitch_control_2]
    type = StitchedMeshGenerator
    inputs = 'delete_center_2 xydelaunay_2'
    stitch_boundaries_pairs = '1001 6'
    clear_stitched_boundary_ids = false
    verbose_stitching = true
  []
  [delete_bounds_2]
    type = BoundaryDeletionGenerator
    input = stitch_control_2
    boundary_names = '1001 1002 1003 1004 1005'
  []
  # Control channel 3
  [highlight_center_3_1]
    type = SubdomainBoundingBoxGenerator
    input = delete_bounds_2
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
  [line_block_3]
    type = LowerDBlockFromSidesetGenerator
    input = delete_center_3
    sidesets = 1001
    new_block_id = 1001
  []
  [isolate_line_3]
    type = BlockDeletionGenerator
    input = line_block_3
    block = '1 2 10 11 100 101 0 13 14 15'
    delete_exteriors = false
  []
  # Reduce to first order to avoid bug with XYDelaunay on EDGE3
  [first_order_3]
    type = ElementOrderConversionGenerator
    input = isolate_line_3
    conversion_type = FIRST_ORDER
  []
  [translate_control_3]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '0 ${fparse -2 * sqrt(2) * inch} 0'
  []
  [xydelaunay_3]
    type = XYDelaunayGenerator
    boundary = first_order_3
    holes = translate_control_3
    stitch_holes = true
    refine_boundary = false
    refine_holes = false
    tri_element_type = TRI6
    hole_boundaries = 'ring'
  []
  [stitch_control_3]
    type = StitchedMeshGenerator
    inputs = 'delete_center_3 xydelaunay_3'
    stitch_boundaries_pairs = '1001 6'
    clear_stitched_boundary_ids = false
    verbose_stitching = true
  []
  [delete_bounds_3]
    type = BoundaryDeletionGenerator
    input = stitch_control_3
    boundary_names = '1001 1002 1003 1004 1005'
  []
  # Control channel 4
  [highlight_center_4_1]
    type = SubdomainBoundingBoxGenerator
    input = delete_bounds_3
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
  [line_block_4]
    type = LowerDBlockFromSidesetGenerator
    input = delete_center_4
    sidesets = 1001
    new_block_id = 1001
  []
  [isolate_line_4]
    type = BlockDeletionGenerator
    input = line_block_4
    block = '1 2 10 11 100 101 0 13 14 15'
    delete_exteriors = false
  []
  # Reduce to first order to avoid bug with XYDelaunay on EDGE3
  [first_order_4]
    type = ElementOrderConversionGenerator
    input = isolate_line_4
    conversion_type = FIRST_ORDER
  []
  [translate_control_4]
    type = TransformGenerator
    input = delete_background
    transform = TRANSLATE
    vector_value = '${fparse 2 * sqrt(2) * inch} 0 0'
  []
  [xydelaunay_4]
    type = XYDelaunayGenerator
    boundary = first_order_4
    holes = translate_control_4
    stitch_holes = true
    refine_boundary = false
    refine_holes = false
    tri_element_type = TRI6
    hole_boundaries = 'ring'
  []
  [stitch_control_4]
    type = StitchedMeshGenerator
    inputs = 'delete_center_4 xydelaunay_4'
    stitch_boundaries_pairs = '1001 6'
    clear_stitched_boundary_ids = false
    verbose_stitching = true
  []
  [delete_bounds_4]
    type = BoundaryDeletionGenerator
    input = stitch_control_4
    boundary_names = '1001 1002 1003 1004 1005'
  []
  # Remove salt and thimble blocks
  [delete_fuel]
    type = BlockDeletionGenerator
    input = delete_bounds_4
    block = '10 11 13 14 15'
    new_boundary = 101
  []
  # Remove dummy blocks
  [delete_dummy]
    type = BlockDeletionGenerator
    input = delete_fuel
    block = '100 101'
    new_boundary = 102
  []
#  [rotate_45]
#    type = TransformGenerator
#    input = delete_dummy
#    transform = ROTATE
#    vector_value = '-45 0 0'
#  []
  # Extrude to 3D
  [extrude]
    type = AdvancedExtruderGenerator
    input = delete_dummy
    heights = '1.70027'
    num_layers = '5'
    direction = '0 0 1'
#    bottom_boundary = 5
#    top_boundary = 6
  []
  [transform_up]
    type = TransformGenerator
    input = extrude
    transform = TRANSLATE
    vector_value = '0 0 0.1875'
  []
  [control_channel_bound_1]
    type = SideSetsFromBoundingBoxGenerator
    input = transform_up
    boundary_new = 20000
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse sqrt(2) * inch} ${fparse 3 * sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 101
  []
  [control_channel_bound_2]
    type = SideSetsFromBoundingBoxGenerator
    input = control_channel_bound_1
    boundary_new = 20001
    bottom_left = '${fparse -3 * sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse -sqrt(2) * inch} ${fparse sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 101
  []
  [control_channel_bound_3]
    type = SideSetsFromBoundingBoxGenerator
    input = control_channel_bound_2
    boundary_new = 20002
    bottom_left = '${fparse -sqrt(2) * inch} ${fparse -3 * sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 101
  []
  [control_channel_bound_4]
    type = SideSetsFromBoundingBoxGenerator
    input = control_channel_bound_3
    boundary_new = 20003
    bottom_left = '${fparse sqrt(2) * inch} ${fparse -sqrt(2) * inch} ${lower_plenum_height}'
    top_right= '${fparse 3 * sqrt(2) * inch} ${fparse sqrt(2) * inch} ${fparse lower_plenum_height + core_height}'
    included_boundaries = 101
  []
[]
