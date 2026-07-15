extends HBoxContainer

@onready var amount_label: Label = $AmountLabel
@onready var currency_icon: TextureRect = $CurrencyIcon

func setup(amount: int, texture:Texture) -> void:
	amount_label.text = "-"+str(amount)
	currency_icon.texture = texture
