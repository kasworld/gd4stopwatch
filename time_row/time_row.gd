extends HBoxContainer

class_name TimeRow

signal started(n:int) # emit when 1st start


func init(idx :int, fsize :int)->void:
	$TimeRecorder.init(idx,fsize, TickLib.tick2str)
	$IntEdit.init(fsize, TickLib.tick2stri)
	$IntEdit.set_limits( 0,true,0,99,false)
	$TimeRecorder.started.connect(_on_tr_started)
	$ToggleButton.theme.default_font_size = fsize

func _on_tr_started(n:int)->void:
	started.emit(n)

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$ToggleButton.text = "Timer"
	else:
		$ToggleButton.text = "Stopwatch"
