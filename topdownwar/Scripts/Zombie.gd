extends KinematicBody2D

var chasing = false
var player

var health = 100
var player_is_on = false

func _physics_process(delta):
	if chasing == true:
		position += (player.position - position)/50
		look_at(player.position)
	
	is_dead()

func is_dead():
	if health <= 0:
		chasing = false
		$Area2D/CollisionShape2D.disabled = true
		$Kill_Area/CollisionShape2D.disabled = true
		$Money_Area/CollisionShape2D.disabled = false
		$CollisionPolygon2D.disabled = true
		$AnimatedSprite.play("cash")

func _on_Area2D_body_entered(body):
	if body.is_in_group("humans"):
		player = body
		chasing = true
		$Area2D/CollisionShape2D.disabled = true



func _on_Kill_Area_body_entered(body):
	if body.is_in_group("humans"):
		player_is_on = true
		$Kill_Timer.start()


func _on_Money_Area_body_entered(body):
	if body.is_in_group("humans"):
		player = body
		player.add_money()
		queue_free()


func _on_Kill_Timer_timeout():
	if player_is_on == true:
		player.health = 0
		player.deadd()
		chasing = false

func _on_Kill_Area_body_exited(body):
	if body.is_in_group("humans"):
		player = body
		player_is_on = false
