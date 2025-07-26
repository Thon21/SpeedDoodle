extends Control

@onready var texture_rect: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TextureRect

func _ready():
	update_preview()

func update_preview():
	texture_rect.texture = GameManager.skin_textures[GameManager.selected_skin]


func _on_skin_button_pressed() -> void:
	if GameManager.selected_skin >= 1:
		GameManager.set_selected_skin(GameManager.selected_skin - 1) 
	else:
		GameManager.set_selected_skin(6) 
	update_preview()
	pass # Replace with function body.


func _on_skin_button_2_pressed() -> void:
	if GameManager.selected_skin <= 5:
		GameManager.set_selected_skin(GameManager.selected_skin + 1) 
	else:
		GameManager.set_selected_skin(0) 
	update_preview()
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	GameManager.start_game()
	pass # Replace with function body.
