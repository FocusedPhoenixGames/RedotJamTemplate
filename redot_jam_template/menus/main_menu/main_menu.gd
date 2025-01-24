extends CanvasLayer

@export var gameScene: PackedScene

@onready var mainContainer: MarginContainer = $%MainContainer
@onready var playButton: Button = $%PlayButton
@onready var optionsButton: Button = $%OptionsButton
@onready var creditsButton: Button = $%CreditsButton
@onready var quitButton: Button = $%QuitButton

var optionsScene = preload("res://redot_jam_template/menus/options_menu/options_menu.tscn")
var creditsScene = preload("res://redot_jam_template/menus/credits_menu/credits_menu.tscn")


func _ready() -> void:
	playButton.pressed.connect(_on_play_pressed)
	optionsButton.pressed.connect(_on_options_pressed)
	creditsButton.pressed.connect(_on_credits_pressed)
	quitButton.pressed.connect(_on_quit_pressed)
	playButton.grab_focus()


func _on_play_pressed() -> void:
	var gameSceneName = gameScene.resource_path
	get_tree().change_scene_to_file(gameSceneName)


func _on_options_pressed() -> void:
	var optionsInstance = optionsScene.instantiate()
	add_child(optionsInstance)
	mainContainer.visible = false
	optionsInstance.back_pressed.connect(_on_options_closed.bind(optionsInstance))


func _on_credits_pressed() -> void:
	var creditsInstance = creditsScene.instantiate()
	add_child(creditsInstance)
	mainContainer.visible = false
	creditsInstance.back_pressed.connect(_on_credits_closed.bind(creditsInstance))


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_closed(optionsInstance: Node) -> void:
	optionsInstance.queue_free()
	mainContainer.visible = true
	optionsButton.grab_focus()


func _on_credits_closed(creditsInstance: Node) -> void:
	creditsInstance.queue_free()
	mainContainer.visible = true
	creditsButton.grab_focus()
