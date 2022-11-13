extends Node2D


# Sinn des Spiels, Wecker Klingelt 22 sec um dich zuwecken, schalte in Aus ! 2 Button Mashing
var progress : int = 0;
var last_pressed : String;
var scenes : Array = []
var active_scene : Dictionary;
var hand_move : int;
#the gameover Timer
onready var alarm : Timer = $Alarm;
onready var start : Node2D =$Paremeter/Start
onready var end : Node2D = $Paremeter/End;
onready var win : Label = $EndScrenes/Win;
onready var lose : Label = $EndScrenes/Lose;
onready var hand : Sprite = $Hand
onready var play_screens : Dictionary = {
	"scene1" : {
		"ress" : $AlarmClock,
		"start": 224,
		"end": 56,
		"length" : 224-56
	}
}
export var limit :int = 5;



func _ready():
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
		hand.position.x -= hand_move;
	check_end();



func check_end():
	if hand.position.x > end.position.x:
		return;
	if scenes.size() > 0:
		return;
	if limit <= progress:
		alarm.stop();
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
	active_scene.ress.show();
	start.position.x = active_scene.start
	end.position.x = active_scene.end;
	hand.position = start.position


func _on_Alarm_timeout():
	lose.show();
