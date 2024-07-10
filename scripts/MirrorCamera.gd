extends Camera3D

@export var xr_camera: XRCamera3D
var mirror: MeshInstance3D
@onready var bola: MeshInstance3D = $"../../Bola"
# Called when the node enters the scene tree for the first time.
func _ready():
	mirror = get_parent().get_parent()
	var n = mirror.global_basis.z
	var p = mirror.global_position
	var d = -(n.x * p.x + n.y * p.y + n.z * p.z)
	print(mirror.global_basis.z)
	print(mirror.global_position)
	print(p.length())
	print(d)
	pass # Replace with function body.

#func p

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var xr_camera_pos = Vector3(-xr_camera.global_position.x, 0, xr_camera.global_position.z)
	var mirror_pos = Vector3(mirror.global_position.x, 0, mirror.global_position.z)
	#global_position = (mirror_pos - xr_camera_pos).rotated(Vector3.UP, mirror.global_rotation.y ** 2) + mirror_pos
	
	#global_rotation_degrees.x = xr_camera.global_rotation_degrees.x
		#
	#global_rotation_degrees.y = -(xr_camera.global_rotation_degrees.y + 180 - mirror.global_rotation_degrees.y)
	#global_rotation_degrees.z = -xr_camera.global_rotation_degrees.z
	
	#TODO: colocar mirror 3d no look at
	var dir: Vector3 = xr_camera.global_basis.z - 2 * (xr_camera.global_basis.z.dot(mirror.global_basis.z)) * mirror.global_basis.z
	
	look_at(dir + global_position, Vector3.UP, true)
	
	var n = -mirror.global_basis.z
	var p = mirror.global_position
	var d = -(n.x * p.x + n.y * p.y + n.z * p.z)
	
	var po = xr_camera.global_position
	
	var t = (-d - n.x * po.x - n.y * po.y - n.z * po.z)/(n.x ** 2 + n.y ** 2 + n.z ** 2)
	
	var x = po.x + n.x * t * 2
	var y = po.y + n.y * t * 2
	var z = po.z + n.z * t * 2
	
	bola.global_position = Vector3(x, y, z)
	
	global_position = Vector3(x, y, z)
