extends FlowContainer

class_name TimeRow

signal started(n:int) # emit when 1st start
signal ended(n:int) # emit when count down over 0

# ⌚  U+0231A  WATCH
# ⌛  U+0231B  HOURGLASS
# ⏰  U+023F0  ALARM CLOCK
# ⏱  U+023F1  STOPWATCH
# ⏲  U+023F2  TIMER CLOCK
# ⏳  U+023F3  HOURGLASS WITH FLOWING SAND
# ⧖  U+029D6  WHITE HOURGLASS
# ⧗  U+029D7  BLACK HOURGLASS

var index :int

func init(idx :int, fsize :int)->void:
	index = idx
	$ToggleButton.theme.default_font_size = fsize
	$IntEdit.init(idx, fsize, TickLib.tick2stri)
	$IntEdit.set_limits( 0,true,0,99,false)
	$IntEdit.value_changed.connect(_on_edit_value_changed)
	$TimeRecorder.init(idx,fsize, TickLib.tick2str)
	$TimeRecorder.started.connect(_on_tr_started)
	$TimeRecorder.overrun.connect(_on_tr_overrun)
	mode_stopwatch()

func _on_tr_started(n :int)->void:
	started.emit(n)

func _on_tr_overrun(v:float)->void:
	$TimeRecorder.reset()
	ended.emit(index)

func _on_edit_value_changed(n :int)->void:
	var v = $IntEdit.get_value()
	$TimeRecorder.set_initial_sec(v)

func mode_stopwatch()->void:
	$ToggleButton.text = "%d:⏱" % index
	$TimeRecorder.set_stopwatch()
	$IntEdit.visible = false

func mode_countdowntimer()->void:
	$ToggleButton.text = "%d:⏳" % index
	$IntEdit.visible = true
	$TimeRecorder.set_initial_sec($IntEdit.get_value())

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		mode_countdowntimer()
	else:
		mode_stopwatch()
