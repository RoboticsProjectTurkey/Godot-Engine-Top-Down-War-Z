extends Area2D

onready var main = get_tree().get_current_scene()


func _on_Finish_Position_body_entered(body):
	if body.name == "Player":
		main.get_node("Player/Camera2D/HUD").show_message("Kurtuldunuz!")
		$Timer.start()


func _on_Timer_timeout():
	get_tree().quit()
