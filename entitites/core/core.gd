extends Organells

@onready var atp_progress_timer: Timer = $ProgressTimer
@onready var  atp_progress_bar: ProgressBar = $ATPDecreaseProgress
@onready var animation: AnimationPlayer = $Animation
@onready var ATP_amount: Panel = $ATPAmountBackground

var core_enegergy: int = 60

var shaking_speed: float = 1.0 

func update_celula():
	animation.speed_scale = remap(core_enegergy, 60, 0, 0.1, 1)
	atp_progress_bar.value = core_enegergy / 60.0 * 100

func _on_atp_decrease_timer_timeout() -> void:
	core_enegergy -= 1
	animation.speed_scale = remap(core_enegergy, 60, 0, 0.1, 1)
	atp_progress_bar.value = core_enegergy / 60.0 * 100
	
	if atp_progress_bar.value == 0:
		print("você perdeu!")

func _on_to_add_atp_button_pressed() -> void:
	if core_enegergy < 60:
		core_enegergy = 60
		update_celula()
	else:
		print("Quantidade Cheia")
