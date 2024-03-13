extends Node2D

var tr_scene = preload("res://time_recorder/time_recorder.tscn")
var tr_list :Array[TimeRecorder]

@onready var StopwatchContainer = $ScrollContainer/VBoxContainer

var vp_rect :Rect2
func _ready() -> void:
	vp_rect = get_viewport_rect()
	$ScrollContainer.size = vp_rect.size
	StopwatchContainer.size = vp_rect.size
	var msgrect = Rect2( vp_rect.size.x * 0.0 ,vp_rect.size.y * 0.5 , vp_rect.size.x * 1.0 , vp_rect.size.y * 0.22 )
	$TimedMessage.init(msgrect, tr("multi stopwatch 3.6.0"))
	$TimedMessage.show_message("click time to start/stop, long press to reset ",1)
	add_stopwatch()

func add_stopwatch()->void:
	var sw = tr_scene.instantiate()
	sw.init(tr_list.size(),200, TickLib.tick2str )
	sw.started.connect(recv_stopwatch_started)
	StopwatchContainer.add_child(sw)
	tr_list.append(sw)
	#sw.grab_focus()
	await get_tree().process_frame
	$ScrollContainer.ensure_control_visible(sw)

func recv_stopwatch_started(n:int)->void:
	if n +1 == tr_list.size():
		add_stopwatch()
