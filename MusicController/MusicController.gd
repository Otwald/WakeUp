extends Control

var end : int = 0;
onready var _music : AudioStreamPlayer =$AudioStreamPlayer;



func play(track_url: String)->void:
	var new_track = load(track_url);
	_music.stream=new_track;
	_music.play();


func stop()->void:
	_music.stop();


func set_volume(db : float)->void:
	_music.volume_db = db;


func get_volume()->float:
	return _music.volume_db; 


func end_sound(win : bool = false)->void:
	if end: 
		return;
	end = true;
	if win:
		end = 1;
	else:
		end = 2;
		set_volume(0.0);
	play('res://Asset/zapsplat_household_alarm_clock_with_bell_knock_over_table_001_44063.mp3');


func _on_AudioStreamPlayer_finished()->void:
	if not end:
		return;
	if end == 1:
		play('res://Asset/human_woman_snoring_37_years_old.mp3');
	if end == 2:
		play('res://Asset/zapsplat_public_places_ambience_suburban_street_residential_through_open_window_birds_cars_pass_15364.mp3');
	
