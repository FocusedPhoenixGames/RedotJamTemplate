@tool
extends CanvasLayer

signal back_pressed

@export var inputs: Array[String]
@export var labelTheme: Theme
@export var buttonTheme: Theme

@onready var remapContainer: GridContainer = %RemapContainer
@onready var backButton: Button = %BackButton


func _ready() -> void:
	_create_action_remap()
	backButton.theme = buttonTheme
	backButton.pressed.connect(_on_back_button_pressed)
	backButton.grab_focus()


func _create_action_remap() -> void:
	var previousItem
	var button1
	
	for index in range(inputs.size()):
		var action = inputs[index]
		var label = Label.new()
		label.text = action
		
		if labelTheme != null:
			label.theme = labelTheme
		
		remapContainer.add_child(label)
		
		var button = RemapButton.new()
		button.action = action
		
		if buttonTheme != null:
			button.theme = buttonTheme
			
		remapContainer.add_child(button)
		
		if index != 0:
			button.focus_neighbor_top = previousItem.get_path()
			previousItem.focus_neighbor_bottom = button.get_path()
		
		if index == inputs.size() - 1:
			backButton.focus_neighbor_top = button.get_path()
			backButton.focus_neighbor_top = button.get_path()
			button.focus_neighbor_bottom = backButton.get_path()
		
		if index == 0:
			button1 = button
			button.focus_neighbor_bottom = backButton.get_path()
			button.grab_focus()
		
		previousItem = button


func _on_back_button_pressed() -> void:
	back_pressed.emit()
