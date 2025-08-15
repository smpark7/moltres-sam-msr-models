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
  [pattern]
    type = PatternedMeshGenerator
    inputs = 'new_bounds new_bounds_2'
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
  [line_block]
    type = LowerDBlockFromSidesetGenerator
    input = delete_center
    sidesets = 1001
    new_block_id = 101
  []
  [isolate_line]
    type = BlockDeletionGenerator
    input = line_block
    block = '1 2 10 11'
    delete_exteriors = false
  []
  # Reduce to first order to avoid bug with XYDelaunay on EDGE3
  [first_order]
    type = ElementOrderConversionGenerator
    input = isolate_line
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
  [xydelaunay]
    type = XYDelaunayGenerator
    boundary = first_order
    holes = delete_background
    hole_boundaries = 3
    stitch_holes = true
    refine_boundary = false
    refine_holes = false
    tri_element_type = TRI6
  []
  [stitch_2]
    type = StitchedMeshGenerator
    inputs = 'delete_center xydelaunay'
    stitch_boundaries_pairs = '1001 6'
    clear_stitched_boundary_ids = false
    verbose_stitching = true
  []
  # Remove salt and thimble blocks
  [delete_fuel]
    type = BlockDeletionGenerator
    input = stitch_2
    block = '10 11 13 14 15'
    new_boundary = 101
  []
  # Extrude to 3D
  [extrude]
    type = AdvancedExtruderGenerator
    input = delete_fuel
    heights = '1.70027'
    num_layers = '10'
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
[]
