extends Resource


# Private imports

const __PAL: Resource = preload("../pal/pal.gd")


# Private variables

var __pal: __PAL


# Lifecylce methods

func _init(_pal: __PAL) -> void:
	__pal = _pal
