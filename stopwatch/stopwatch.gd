extends Container

class_name Stopwatch

signal started(n:int)

var start_tick :float
var sum_tick :float
var is_running :bool
var is_started :bool
var number :int

func init(swsize :Vector2, n :int)->void:
	size = swsize
	custom_minimum_size = swsize
	number = n
	$ButtonSec.theme.default_font_size = size.x/4.2

func _process(delta: float) -> void:
	if is_started :
		var dur :float
		if is_running:
			dur = sum_tick + Time.get_unix_time_from_system() - start_tick
		else : # paused
			dur = sum_tick
		$ButtonSec.text = "%02.0f:%02.0f.%02.0f" %[ dur as int / 60 , dur as int % 60 , clampi( (dur - int(dur))*100, 0,99) ]

	else:
		$ButtonSec.text = "00:00.00"

func reset() -> void:
	is_running = false
	is_started = false
	sum_tick = 0

var button_down_tick :float
func _on_button_sec_button_down() -> void:
	button_down_tick = Time.get_unix_time_from_system()
	$Timer.start(1.0)

func _on_button_sec_button_up() -> void:
	$Timer.stop()
	# check long press
	if Time.get_unix_time_from_system() - button_down_tick > 1.0:
		reset()
	else:
		if not is_started:
			is_started = true
			started.emit(number)
		if not is_running:
			is_running = true
			start_tick = Time.get_unix_time_from_system()
		else:
			is_running = false
			sum_tick += Time.get_unix_time_from_system() - start_tick

	button_down_tick = 0

func _on_timer_timeout() -> void:
	reset()
