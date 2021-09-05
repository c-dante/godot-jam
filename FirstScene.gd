extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	resource_grant()

func demoSurfaceMesh():
	spawnRocks()
	# var vertices = PoolVector3Array()
	# vertices.push_back(Vector3(0, 10, 0))
	# vertices.push_back(Vector3(10, 0, 0))
	# vertices.push_back(Vector3(0, 0, 10))
	# var arrays = []
	# arrays.resize(ArrayMesh.ARRAY_MAX)
	# arrays[ArrayMesh.ARRAY_VERTEX] = vertices

	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	# Create the Mesh.
	# arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	# st.add_color(Color(1, 0, 1))
	# st.add_uv(Vector2(0, 0))
	# st.add_vertex(Vector3(0, 0, 0))
	# st.add_vertex(Vector3(10, 0, 0))
	# st.add_vertex(Vector3(0, 10, 0))

	st.add_vertex(Vector3(0, 0, 0))
	st.add_vertex(Vector3(0, 10, 0))
	st.add_vertex(Vector3(0, 0, 0))
	# st.add_vertex(Vector3(0, 0, 0))
	# st.add_vertex(Vector3(10, 0, 0))
	st.commit(arr_mesh)


	var m = MeshInstance.new()
	m.mesh = arr_mesh
	add_child(m)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func spawnRocks():
	# var spawnArea = $"Level/Floor"
	# print(spawnArea.)
	for i in range(10):
		print(i)

func _on_Area_body_entered(body: Node):
	print("ENTER GLOBAL", body)

func resource_grant():
	print($Player)
	print(Resources)
