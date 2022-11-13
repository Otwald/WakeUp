extends Node2D

signal restart_pressed

# Sinn des Spiels, Wecker Klingelt 22 sec um dich zuwecken, schalte in Aus ! 2 Button Mashing
var progress : int = 0;
var hand_move : int;
var last_pressed : String;
var scenes : Array = []
var active_scene : Dictionary;
var play_screens : Dictionary = {
	"scene1" : {
		"ress" : preload("res://PlayScene/Scenes/Scene1.tscn"),
		"length" : 224-64
	},
	"scene2" : {
		"ress" : preload("res://PlayScene/Scenes/Scene2.tscn"),
		"length" : 232-40
	},
	"scene3" : {
		"ress" : preload("res://PlayScene/Scenes/Scene3.tscn"),
		"length" : 232-24
	},
	"scene4" : {
		"ress" : preload("res://PlayScene/Scenes/Scene4.tscn"),
		"length" : 232-24
	},
	"scene5" : {
		"ress" : preload("res://PlayScene/Scenes/Scene5.tscn"),
		"length" : 232-24
	},
	"sceneend" : {
		"ress" : preload("res://PlayScene/Scenes/SceneEnd.tscn"),
		"length" : 224-56
	}
}
var end : Node2D;
var start : Node2D;
#the gameover Timer
onready var alarm : Timer = $Alarm;
onready var win : Node2D = $EndScrenes/Win;
onready var lose : Node2D = $EndScrenes/Lose;
onready var player : Node2D = $Player;
onready var hand : Sprite = $Player/Hand;

export var limit :int = 100;



func _ready():
	if connect("restart_pressed", get_parent(), "_on_Restart_pressed"):
		pass
	scenes = play_screens.keys();
	var total_length : int = 0;
	for scene in scenes:
		total_length += play_screens[scene].length
	_set_scene_parameters()
	hand_move =  total_length/limit;
	win.hide();
	lose.hide();


func _process(_delta):
	if get_input():
		progress += 1;
		player.position.x -= hand_move;
	check_end();



func check_end():
	if player.position.x > end.position.x:
		return;
	if scenes.size() > 0:
		$Scenes.get_child(0).queue_free();
		_set_scene_parameters();
		return;
	if limit <= progress:
		alarm.stop();
		player.hide();
		win.show();

func get_input()->bool:
	var out : bool = false;
	var but_a : bool = Input.is_action_just_pressed("mash_a");
	var but_b : bool =  Input.is_action_just_pressed("mash_b");
	if last_pressed != 'a' and but_a:
		last_pressed = 'a';
		hand.frame = 1;
		out = true;
	if last_pressed != 'b' and but_b:
		last_pressed = 'b';
		hand.frame = 2;
		out = true;
	if but_a and but_b :
		print("both");
		hand.frame = 0;
		out = false;
	return out


# sets start and end points transform and activates scene sprite
func _set_scene_parameters():
	active_scene = play_screens[scenes[0]]
	scenes.pop_front();
	var init_scene = active_scene.ress.instance();
	$Scenes.add_child(init_scene);
	start = init_scene.get_node("Paremeter/Start");
	end = init_scene.get_node("Paremeter/End");
	player.position = start.position


func _on_Alarm_timeout():
	lose.show();


func _on_Restart_pressed():
	emit_signal("restart_pressed");
