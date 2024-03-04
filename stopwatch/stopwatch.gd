extends HBoxContainer

class_name Stopwatch

var start_tick :float
var sum_tick :float
var is_running :bool
var is_started :bool

func init(sz :Vector2)->void:
	size = sz
	theme.default_font_size = sz.x /10

func _process(delta: float) -> void:
	if is_started :
		var dur :float
		if is_running:
			dur = sum_tick + Time.get_unix_time_from_system() - start_tick
		else : # paused
			dur = sum_tick
		$LabelSec.text = "%02.0f:%02.0f.%02.0f" %[ dur/60.0 , dur as int % 60 , (dur - int(dur))*100 ]

	else:
		$LabelSec.text = "00:00.00"

func _on_button_start_pressed() -> void:

	if not is_started:
		is_started = true

	if not is_running:
		is_running = true
		$ButtonStart.text = "Pause"
		start_tick = Time.get_unix_time_from_system()
	else:
		is_running = false
		$ButtonStart.text = "Start"
		sum_tick += Time.get_unix_time_from_system() - start_tick


func _on_button_reset_pressed() -> void:
	$ButtonStart.text = "Start"
	is_running = false
	is_started = false
	sum_tick = 0

