extends Node2D

var stopwatch_scene = preload("res://stopwatch/stopwatch.tscn")

func _ready() -> void:
	var vp_rect = get_viewport_rect()
	var msgrect = Rect2( vp_rect.size.x * 0.0 ,vp_rect.size.y * 0.5 , vp_rect.size.x * 1.0 , vp_rect.size.y * 0.2 )
	$TimedMessage.init(msgrect, tr("multi stopwatch 1.0.0"))
	$TimedMessage.show_message("")

	const stopwatch_count = 12
	var sz = Vector2(vp_rect.size.x , vp_rect.size.y /stopwatch_count)
	for i in stopwatch_count :
		var sw = stopwatch_scene.instantiate()
		sw.init(sz)
		sw.position.y = i * sz.y
		add_child(sw)
