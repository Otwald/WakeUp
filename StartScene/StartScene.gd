extends Node

signal start_pressed;


func _on_Start_pressed():
	emit_signal("start_pressed");
