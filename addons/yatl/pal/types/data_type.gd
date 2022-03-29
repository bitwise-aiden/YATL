# Public methods

static func from_data(
	_data_type: Resource,
	_data # Variant
): # Variant
	var instance = _data_type.new()

	var properties: Dictionary = {}

	for property in instance.get_property_list():
		properties[property['name']] = property['type']

	for property_name in _data:
		if !properties.has(property_name):
			pass # TODO: Determine what happens when property doesn't exist in data

		var value = _data[property_name]

		if properties[property_name] == TYPE_OBJECT:
			value = instance._create_object(property_name, value)
		elif properties[property_name] == TYPE_ARRAY:
			value = instance.__create_object_array(property_name, value)

		instance.set(property_name, value)

	return instance


# Protected methods

func _create_object(
	_type: String,
	_data: Dictionary
): # Subtype of self
	var type_parts: PoolStringArray = _type \
		.rstrip("s") \
		.split("_", false)

	while !type_parts.empty():
		var type_name: String = type_parts \
			.join(" ") \
			.capitalize() \
			.replace(" ", "")

		var data_type: Resource = get(type_name)
		if data_type:
			return data_type.from_data(data_type, _data)

		type_parts.remove(0)

	# TODO: Determine what happens when no type is found

	return null


# Private methods

func __create_object_array(
	_type: String,
	_data_array: Array
) -> Array:
	var instantiated_data: Array = []

	for data in _data_array:
		instantiated_data.append(_create_object(_type, data))

	return instantiated_data
