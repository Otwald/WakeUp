extends Node

onready var play_scene : PackedScene = preload("res://PlayScene/PlayScene.tscn");
onready var start_screen : Node = $StartScene;



func _on_StartScene_start_pressed():
	start_screen.queue_free();
	var init_scene = play_scene.instance();
	add_child(init_scene);


func _on_Restart_pressed():
	get_tree().reload_current_scene();