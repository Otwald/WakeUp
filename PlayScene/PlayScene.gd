extends Node2D


# Sinn des Spiels, Wecker Klingelt 22 sec um dich zuwecken, schalte in Aus ! 2 Button Mashing
var progress : int = 0;
var last_pressed : String;
#the gameover Timer
onready var alarm : Timer = $Alarm;
onready var win : Label = $Win;
onready var lose : Label = $Lose;

export var limit :int = 5;

func _ready():
    win.hide();
    lose.hide();


func _process(_delta):
    if get_input():
        progress += 1;
    if limit <= progress:
        win.show();


func get_input()->bool:
    var out : bool = false;
    var but_a : bool = Input.is_action_just_released("mash_a");
    var but_b : bool =  Input.is_action_just_released("mash_b");
    if last_pressed != 'a' and but_a:
        last_pressed = 'a';
        out = true;
    if last_pressed != 'b' and but_b:
        last_pressed = 'b';
        out = true;
    if but_a and but_b :
        print("both)");
        out = false;
    return out

func _on_Alarm_timeout():
	lose.show();
