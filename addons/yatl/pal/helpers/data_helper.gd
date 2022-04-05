# Public methods

static func as_data_type(
	_data_type: Resource,
	_data # Variant
): # Variant
	if _data == TYPE_ARRAY:
		var data: Array = []

		for value in _data:
			data.append(_data_type.from_data(_data_type, value))

		return data

	if _data == TYPE_DICTIONARY:
		return _data_type.from_data(_data_type, _data)

	return null
