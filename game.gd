extends Node3D

var stage = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		$NightLight/AnimationPlayer.current_animation = "dim"
	if Input.is_action_just_pressed("ui_up"):
		$NightLight/AnimationPlayer.current_animation = "flicker"
	if Input.is_action_just_pressed("exit"):
		$ConfirmExit.visible = true



func _on_yes_button_pressed() -> void:
	get_tree().quit()


func _on_no_button_pressed() -> void:
	$ConfirmExit.visible = false


func _on_continue_button_pressed() -> void:
	$BriefingScreen.visible = false
	$FootageTimer.start()


func _on_footage_timer_timeout() -> void:
	$BriefingScreen.visible = true
	stage += 1
	
	match stage:
		2:
			$BriefingScreen/Label.text = """SCP-122-1 Name: Anna Talinn
			Age: 3 years old
			Date of Use: 4/28/2018
			"""
		3:
			$BriefingScreen/Label.text = """SCP-122-1 Name: Anna Talinn
			Age: 5 years old
			Date of Use: 6/26/2020
			"""
		4:
			$BriefingScreen/Label.text = """SCP-122-1 Name: Anna Talinn
			Age: 7 years old
			Date of Use: 9/15/2022
			"""


func _on_start_screen_continue_button_pressed() -> void:
	$StartScreen.visible = false
