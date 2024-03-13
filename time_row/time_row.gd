extends HBoxContainer

class_name TimeRow

signal started(n:int) # emit when 1st start


func init(idx :int, fsize :int)->void:
	$TimeRecorder.init(idx,fsize, TickLib.tick2str)
	$IntEdit.init(0,true,0,99,false, TickLib.tick2stri)
	$TimeRecorder.started.connect(_on_tr_started)

func _on_tr_started(n:int)->void:
	started.emit(n)

func _on_check_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
