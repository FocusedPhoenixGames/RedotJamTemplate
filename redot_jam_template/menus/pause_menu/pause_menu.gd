extends CanvasLayer

@onready var panelContainer = %PanelContainer
@onready var resumeButton: Button = %ResumeButton
@onready var optionsButton: Button = %OptionsButton
@onready var quitButton: Button = %QuitButton

var optionsScreenScene = preload("res://redot_jam_template/menus/options_menu/options_menu.tscn")
var isClosing: bool


func _ready() -> void:
	get_tree().paused = true
	panelContainer.pivot_offset = panelContainer.size / 2
	
	resumeButton.grab_focus()
	resumeButton.pressed.connect(on_resume_pressed)
	optionsButton.pressed.connect(on_options_pressed)
	quitButton.pressed.connect(on_quit_pressed)
	
	
	var tween = create_tween()
	tween.tween_property(panelContainer, "scale", Vector2.ZERO, 0)
	tween.tween_property(panelContainer, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause"):
		close()
		get_tree().root.set_input_as_handled()


func close() -> void:
	if isClosing:
		return
	
	var tween = create_tween()
	tween.tween_property(panelContainer, "scale", Vector2.ONE, 0)
	tween.tween_property(panelContainer, "scale", Vector2.ZERO, 0.3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	await tween.finished
	
	get_tree().paused = false
	queue_free()


func on_resume_pressed() -> void:
	close()


func on_options_pressed() -> void:
	var optionsScreenInstance = optionsScreenScene.instantiate()
	add_child(optionsScreenInstance)
	optionsScreenInstance.back_pressed.connect(on_options_back_pressed.bind(optionsScreenInstance))


func on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://redot_jam_template/menus/main_menu/main_menu.tscn")


func on_options_back_pressed(optionsScreen: Node) -> void:
	optionsScreen.queue_free()
	optionsButton.grab_focus()
