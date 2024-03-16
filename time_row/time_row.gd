extends FlowContainer

class_name TimeRow

@onready var time_preset_menu = $HBoxContainer/TimePresetMenu
@onready var intedit = $HBoxContainer/IntEdit

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

var timepreset_list = [
	["10초", 10],
	["15초", 15],
	["30초", 30],
	["1분", 1*60],
	["3분", 3*60],
	["5분", 5*60],
	["10분", 10*60],
	["15분", 15*60],
]

var index :int

func init(idx :int, fsize :int)->void:
	index = idx
	$ToggleButton.theme.default_font_size = fsize
	intedit.init(idx, fsize, TickLib.tick2stri)
	intedit.set_limits( 0,true,0,99,false)
	intedit.value_changed.connect(_on_edit_value_changed)
	$TimeRecorder.init(idx,fsize, TickLib.tick2str)
	$TimeRecorder.started.connect(_on_tr_started)
	$TimeRecorder.overrun.connect(_on_tr_overrun)
	time_preset_menu.theme.default_font_size = fsize/2.5
	time_preset_menu.get_popup().theme = Theme.new()
	time_preset_menu.get_popup().theme.default_font_size = fsize/2.5
	time_preset_menu.get_popup().index_pressed.connect(_on_timepreset_menu_index_pressed)
	make_preset_popup()
	mode_stopwatch()

func _on_tr_started(n :int)->void:
	started.emit(n)

func _on_tr_overrun(v:float)->void:
	$TimeRecorder.reset()
	ended.emit(index)

func _on_edit_value_changed(n :int)->void:
	var v = intedit.get_value()
	$TimeRecorder.set_initial_sec(v)

func make_preset_popup()->void:
	for i in timepreset_list.size():
		time_preset_menu.get_popup().add_item(timepreset_list[i][0],i)

func _on_timepreset_menu_index_pressed(sel :int)->void:
	var v = timepreset_list[sel][1]
	intedit.set_init_value(v)
	$TimeRecorder.set_initial_sec(v)

func mode_stopwatch()->void:
	$ToggleButton.text = "%d:⏱" % index
	$TimeRecorder.set_stopwatch()
	$HBoxContainer.visible = false

func mode_countdowntimer()->void:
	$ToggleButton.text = "%d:⏳" % index
	$TimeRecorder.set_initial_sec(intedit.get_value())
	$HBoxContainer.visible = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		mode_countdowntimer()
	else:
		mode_stopwatch()
