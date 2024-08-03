extends XRCamera3D
class_name AvatarOnXR

@export var avatar: Node3D
@export var avatar_for_mirror: Node3D
var look_offset: Node3D
var look_offset_y := 0.0
var avatar_skeleton: Skeleton3D = avatar
var avatar_mirror_skeleton: Skeleton3D = avatar_for_mirror
var neck_id := 0

func remove_neck_spring_bones(secondary: VRMSecondary, bone: int):
	for child in avatar_skeleton.get_bone_children(bone):
		remove_neck_spring_bones(secondary, child)
	var bone_name = avatar_skeleton.get_bone_name(bone)
	for spring_bone in secondary.spring_bones:
		var joint_id = len(spring_bone.joint_nodes) - 1
		while joint_id >= 0:
			if spring_bone.joint_nodes[joint_id] == bone_name:
				print("removing " + bone_name)
				spring_bone.joint_nodes.remove_at(joint_id)
			joint_id -= 1

func _ready():
	avatar_skeleton = avatar.get_node("%GeneralSkeleton")
	avatar_mirror_skeleton = avatar_for_mirror.get_node("%GeneralSkeleton")
	neck_id = avatar_skeleton.find_bone("Neck")
	look_offset = avatar.get_node("%LookOffset")
	look_offset_y = look_offset.global_position.y - avatar.global_position.y
	var vrm_secondary: VRMSecondary = avatar.get_node("secondary")
	for bone in avatar_skeleton.get_bone_children(neck_id):
		remove_neck_spring_bones(vrm_secondary, bone)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	avatar.global_rotation_degrees.y = global_rotation_degrees.y + 180
	avatar.global_position = Vector3(global_position.x, global_position.y - look_offset_y, global_position.z)
	avatar_for_mirror.global_rotation_degrees.y = global_rotation_degrees.y + 180
	avatar_for_mirror.global_position = Vector3(global_position.x, global_position.y - look_offset_y, global_position.z)
	avatar_skeleton.set_bone_pose_scale(neck_id, Vector3.ZERO)
	
