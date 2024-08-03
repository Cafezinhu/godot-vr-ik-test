@tool
extends Camera3D

@export var xr_camera: XRCamera3D
var mirror: MeshInstance3D
enum Eye {Left, Right}
@export var eye: Eye
var eye_position: Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	mirror = get_parent().get_parent()
	if eye == Eye.Left:
		eye_position = xr_camera.get_node("LeftEye")
	else:
		eye_position = xr_camera.get_node("RightEye")
	if Engine.is_editor_hint():
		eye_position = EditorInterface.get_editor_viewport_3d(0).get_camera_3d()
	set_resolution()

func set_resolution():
	var openxr_interface: OpenXRInterface = XRServer.find_interface("OpenXR")
	if not openxr_interface or not openxr_interface.is_initialized():
		var subviewport: SubViewport = get_parent()
		subviewport.size = get_tree().root.get_viewport().size
		print(get_tree().root.get_viewport().size)
		print(subviewport.size)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mirror.rotation_degrees.z = 0

	var mirror_pos = Vector3(mirror.global_position.x, 0, mirror.global_position.z)

	var dir: Vector3 = eye_position.global_basis.z - 2 * (eye_position.global_basis.z.dot(mirror.global_basis.z)) * mirror.global_basis.z
	
	look_at(dir + global_position, mirror.global_basis.y.rotated(mirror.global_basis.z, eye_position.global_rotation.z), true)
	
	var n = -mirror.global_basis.z
	var p = mirror.global_position
	var d = -(n.x * p.x + n.y * p.y + n.z * p.z)
	
	var po = eye_position.global_position
	
	var t = (-d - n.x * po.x - n.y * po.y - n.z * po.z)/(n.x ** 2 + n.y ** 2 + n.z ** 2)
	
	var x = po.x + n.x * t * 2
	var y = po.y + n.y * t * 2
	var z = po.z + n.z * t * 2
	
	global_position = Vector3(x, y, z)
	near = t
