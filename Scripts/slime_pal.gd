extends Area2D

const SLIMEBULLET = preload("res://Scenes/slime_bullet.tscn")

var teleport_to = null
var holder = null  # whoever picked this slime up

func _on_body_entered(body):
	print("body entered: ", body.name)
	if body.name == "MrFalls" and holder == null:
		holder = body
		var target = get_tree().get_first_node_in_group("leave_point")
		if target:
			teleport_to = target.global_position
		Global.has_slime = true
		$Slimey.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire") and holder:
		print("dog")
		var bullet_instance = SLIMEBULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = holder.global_position
		bullet_instance.rotation = (get_global_mouse_position() - holder.global_position).angle()
		Global.has_slime = false
		queue_free()
