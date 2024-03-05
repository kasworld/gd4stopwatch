extends Node2D

var stopwatch_scene = preload("res://stopwatch/stopwatch.tscn")
var stopwatch_list :Array[Stopwatch]

@onready var StopwatchContainer = $ScrollContainer/VBoxContainer

var vp_rect :Rect2
func _ready() -> void:
	vp_rect = get_viewport_rect()
	$ScrollContainer.size = vp_rect.size
	StopwatchContainer.size = vp_rect.size
	var msgrect = Rect2( vp_rect.size.x * 0.0 ,vp_rect.size.y * 0.5 , vp_rect.size.x * 1.0 , vp_rect.size.y * 0.22 )
	$TimedMessage.init(msgrect, tr("multi stopwatch 2.1.0"))
	$TimedMessage.show_message("click time to start/stop, long press to reset ")
	add_stopwatch()

func add_stopwatch()->void:
	var sw = stopwatch_scene.instantiate()
	sw.init( Vector2(vp_rect.size.x, vp_rect.size.y/6) , stopwatch_list.size())
	sw.started.connect(recv_stopwatch_started)
	StopwatchContainer.add_child(sw)
	stopwatch_list.append(sw)
	sw.grab_focus()
	#$ScrollContainer.ensure_control_visible(sw)

func recv_stopwatch_started(n:int)->void:
	if n +1 == stopwatch_list.size():
		add_stopwatch()
