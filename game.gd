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

# Go to the game screen and play light flickering and dimming animations
func _on_continue_button_pressed() -> void:
	$BriefingScreen.visible = false
	$FootageTimer.start()
	
	match stage:
		2:
			await get_tree().create_timer(7).timeout
			$NightLight/AnimationPlayer.play("dim")
		3:
			await get_tree().create_timer(6).timeout
			$NightLight/AnimationPlayer.play("dim")
			await get_tree().create_timer(5).timeout
			$NightLight/AnimationPlayer.play("dim")
			await get_tree().create_timer(6).timeout
			$NightLight/AnimationPlayer.play("flicker")
		4:
			await get_tree().create_timer(4).timeout
			$NightLight/AnimationPlayer.play("flicker")
			await get_tree().create_timer(5).timeout
			$NightLight/AnimationPlayer.play("flicker")
			await get_tree().create_timer(5).timeout
			$NightLight/AnimationPlayer.play("flicker")
			await get_tree().create_timer(3).timeout
			$NightLight/AnimationPlayer.play("flicker")


# When timer ends, go to the next stage and change the briefing text
func _on_footage_timer_timeout() -> void:
	$NoteScreen.visible = true
	$BriefingScreen.visible = true
	stage += 1
	
	match stage:
		2:
			$BriefingScreen/Label.text = """SCP-122-1 Name: Anna Talinn
			Age: 3 years old
			Date of Use: 4/28/2018
			SCP-122-2 Distance: 6 meters
			"""
			$Angel.visible = true
		3:
			$BriefingScreen/Label.text = """SCP-122-1 Name: Anna Talinn
			Age: 5 years old
			Date of Use: 6/26/2020
			SCP-122-2 Distance: 2 meters
			"""
			$Angel.position = $Stage3Marker.position
			$Angel.frame = 1
		4:
			$BriefingScreen/Label.text = """SCP-122-1 Name: Anna Talinn
			Age: 7 years old
			Date of Use: 9/15/2022
			SCP-122-2 Distance: 6 centimeters
			"""
			$Angel.position = $Stage4Marker.position
			$Angel.frame = 2
		5:
			$BriefingScreen/Label.text = """ERROR
			"""

# Hide start screen
func _on_start_screen_continue_button_pressed() -> void:
	$StartScreen.visible = false

# Hide note taking screen
func _on_note_screen_confirm_pressed() -> void:
	if len($NoteScreen/Control/VBoxContainer/HBoxContainer/LineEdit.text) != 0 and len($NoteScreen/Control/VBoxContainer/HBoxContainer2/LineEdit.text) != 0:
		$NoteScreen.visible = false
		$NoteScreen/Control/VBoxContainer/HBoxContainer2/LineEdit.text = ""
		$NoteScreen/Control/VBoxContainer/HBoxContainer/LineEdit.text = ""
