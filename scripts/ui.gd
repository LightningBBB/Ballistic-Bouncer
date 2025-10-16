extends CanvasLayer

@onready var bar = $ProgressBar

func _process(_delta: float) -> void:
	bar.value = Global.experience
