extends Node2D

var voices = DisplayServer.tts_get_voices_for_language(OS.get_locale_language())
func text2speech(s :String):
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(s, voices[0])

var tr_scene = preload("res://time_row/time_row.tscn")
@onready var tr_container = $ScrollContainer/VBoxContainer

var vp_rect :Rect2
func _ready() -> void:
	vp_rect = get_viewport_rect()
	$ScrollContainer.size = vp_rect.size
	tr_container.size = vp_rect.size
	var msgrect = Rect2( vp_rect.size.x * 0.0 ,vp_rect.size.y * 0.5 , vp_rect.size.x * 1.0 , vp_rect.size.y * 0.22 )
	$TimedMessage.init(msgrect, tr("multi stopwatch 6.0.0"))
	$TimedMessage.show_message("toggle timer/stopwatch\nclick time to start/stop, long press to reset ",2)
	add_stopwatch()

func add_stopwatch()->void:
	var sw = tr_scene.instantiate()
	var n = tr_container.get_child_count()
	tr_container.add_child(sw)
	sw.init(n,180)
	sw.started.connect(_on_tr_started)
	sw.ended.connect(_on_tr_ended)
	await get_tree().process_frame
	$ScrollContainer.ensure_control_visible(sw)

func _on_tr_started(n:int)->void:
	var tr_size = tr_container.get_child_count()
	if n +1 == tr_size:
		add_stopwatch()

func _on_tr_ended(n:int)->void:
	text2speech("%d번 타이머가 종료되었습니다." % n)
