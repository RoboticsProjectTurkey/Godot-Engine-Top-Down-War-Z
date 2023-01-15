extends Area2D

var speed = 750
var body_idd
var body_shapee
var local_shapee

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += speed * delta * transform.x



func _on_bullet_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("zombies"):
		body.health -= 10
	queue_free()
	body_idd = body_id
	body_shapee = body_shape
	local_shapee = local_shape
