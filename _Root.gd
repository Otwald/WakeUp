extends Node


var soundtracks : Dictionary = {
	'start' : 'res://Asset/tspt_alarm_clock_ticking_loop_002.mp3',
	'game' : 'res://Asset/zapsplat_household_alarm_clock_old_fashioned_ring_long_44059.mp3'
};
onready var play_scene : PackedScene = preload("res://PlayScene/PlayScene.tscn");
onready var start_screen : Node = $StartScene;


func _ready():
	MusicController.play(soundtracks.start)

func _on_StartScene_start_pressed():
	start_screen.queue_free();
	MusicController.play(soundtracks.game);
	MusicController.set_volume(-20.0);
	var init_scene = play_scene.instance();
	add_child(init_scene);



func _on_Restart_pressed():
	get_tree().reload_current_scene();