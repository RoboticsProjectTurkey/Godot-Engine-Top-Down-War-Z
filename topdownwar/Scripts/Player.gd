extends KinematicBody2D

var velocity = Vector2()
export (int) var speed = 200

var health = 100
var kill = 0
var dead = false
var money = 0

var bullet = preload("res://Scenes/bullet.tscn")

var with_gun = 0 #0:yok 1:pistol 2:makineli
var bullet_area_bodies = []

onready var main = get_tree().get_current_scene()

func _physics_process(delta):
	if dead == true:
		return
	get_input()

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.get_action_strength("ui_down"):
		velocity = Vector2(-speed,0).rotated(rotation)
	if Input.get_action_strength("ui_up"):
		velocity = Vector2(speed,0).rotated(rotation)
	velocity = move_and_slide(velocity)

func send_bullet():
	if Input.is_key_pressed(KEY_E) and with_gun != 0:
		var b = bullet.instance()
		add_child(b)
		b.transform = $Muzzle.transform
		
		var x = 0
		while x <= bullet_area_bodies.size()-1:
			bullet_area_bodies[x].player = main.get_node("Player")
			bullet_area_bodies[x].chasing = true
			bullet_area_bodies[x].get_node("Area2D/CollisionShape2D").disabled = true
			x+=1


func _on_change_gun_timer_timeout():
	change_gun()

func change_gun():
	if Input.is_key_pressed(KEY_A) and with_gun == 0 and dead == false:
		with_gun  = 1
		$AnimatedSprite.play("with_gun")
		$send_bullet_timer.wait_time = 0.2
	elif Input.is_key_pressed(KEY_A) and with_gun == 1:
		with_gun = 2
		$AnimatedSprite.play("with_machine")
		$send_bullet_timer.wait_time = 0.05
	elif Input.is_key_pressed(KEY_A) and with_gun == 2:
		with_gun = 0
		$AnimatedSprite.play("stand")


func _on_send_bullet_timer_timeout():
	send_bullet()

func deadd():
	if health <= 0:
		dead = true
		with_gun = 0
		$AnimatedSprite.play("dead")
		main.get_node("Player/Camera2D/HUD").show_message("Game Over")
		$Dead_Timer.start()

func add_money():
	money += 1
	main.get_node("Player/Camera2D/HUD").upgrade_money(money)


func _on_Dead_Timer_timeout():
	get_tree().quit()

func _on_bullet_area2d_body_entered(body):
	if body.is_in_group("zombies"):
		bullet_area_bodies.append(body)
func _on_bullet_area2d_body_exited(body):
	if body.is_in_group("zombies"):
		var x = 0
		while bullet_area_bodies.size()-1 >= x:
			if bullet_area_bodies[x] == body:
				bullet_area_bodies.remove(x)
				break
			x+=1
