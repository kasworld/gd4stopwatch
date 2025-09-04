extends Node2D

var voices = DisplayServer.tts_get_voices_for_language(OS.get_locale_language())
func text2speech(s :String):
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(s, voices[0])

var tr_scene = preload("res://time_row/time_row.tscn")
@onready var tr_container = $ScrollContainer/VBoxContainer

var vp_rect :Rect2
func _ready() -> void:
	get_viewport().size_changed.connect(on_viewport_size_changed)
	on_viewport_size_changed()
	var msgrect = Rect2( vp_rect.size.x * 0.0 ,vp_rect.size.y * 0.25 , vp_rect.size.x * 1.0 , vp_rect.size.y * 0.5 )
	$TimedMessage.init(vp_rect.size.x/20, msgrect, tr("multi stopwatch 10.0.0"))
	$TimedMessage.show_message("toggle timer/stopwatch\nclick time to start/stop, long press to reset ",3)
	add_stopwatch()

func on_viewport_size_changed():
	vp_rect = get_viewport_rect()
	$ScrollContainer.size = vp_rect.size
	tr_container.size = vp_rect.size
	for n in tr_container.get_children():
		n.set_fsize(vp_rect.size.x/9)

func add_stopwatch()->void:
	var sw = tr_scene.instantiate()
	var n = tr_container.get_child_count()
	tr_container.add_child(sw)
	sw.init(n,vp_rect.size.x/9)
	sw.started.connect(_on_tr_started)
	sw.ended.connect(_on_tr_ended)
	await get_tree().process_frame
	$ScrollContainer.ensure_control_visible(sw)

func _on_tr_started(n:int)->void:
	var tr_size = tr_container.get_child_count()
	if n +1 == tr_size:
		add_stopwatch()

func _on_tr_ended(n:int)->void:
	var msg = "%d번 타이머가 종료되었습니다." % n
	text2speech(msg)
	$TimedMessage.show_message(msg,3)
