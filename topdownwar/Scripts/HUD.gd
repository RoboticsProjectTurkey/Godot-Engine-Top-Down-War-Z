extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Messsage_Label.hide()
	$ProgressBar.visible  = true
	$Info.visible = true
	$Kill_Label.visible = true
	$Messsage_Label.visible = true
	$"İnfo2".visible = true
	$Money_Label.visible = true

func upgrade_health(health):
	$ProgressBar.value = health

func upgrade_kill(kill):
	$Kill_Label.text = str(kill)

func show_message(message):
	$Messsage_Label.text = str(message)
	$Messsage_Label.show()
	$message_Timer.start()


func _on_message_Timer_timeout():
	$Messsage_Label.hide()

func upgrade_money(cash):
	$Money_Label.text = str(cash)
