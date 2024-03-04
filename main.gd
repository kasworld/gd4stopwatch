extends Node2D

func _ready() -> void:
	var vp_rect = get_viewport_rect()
	var msgrect = Rect2( vp_rect.size.x * 0.1 ,vp_rect.size.y * 0.3 , vp_rect.size.x * 0.8 , vp_rect.size.y * 0.3 )
	$TimedMessage.init(msgrect, tr("multi stopwatch 1.0.0"))
	$TimedMessage.show_message("시작합니다.")
	var sz = Vector2(vp_rect.size.x , vp_rect.size.y /4)
	$Stopwatch.init(sz)
