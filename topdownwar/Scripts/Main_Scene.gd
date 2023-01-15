extends Node2D

var main

func _ready():
	main = get_tree().get_current_scene()
	$Player/Camera2D/HUD.upgrade_health($Player.health)
	$Player/Camera2D/HUD.upgrade_kill($Player.kill)
	$Player/Camera2D/HUD.upgrade_money($Player.money)
	$Player/Camera2D/HUD.show_message("Deneme Sahnesi")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Game_Area_body_exited(body):
	if body.name == "Player":
		$Player.position = $Spawn_Position_Player.position
