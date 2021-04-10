class_name Response


# Private variables
var __data = "" # variant
var __headers: Dictionary = {
	# key: String, header name
	# value: Variant, header value
}
var __status: int = 200


# Public methods
func data(data) -> void: # Variant
	self.__data = data


func header(name: String, value) -> void: # Variant
	self.__headers[name.to_lower()] = value


func json(data) -> void: # Variant
	self.header("content-type", "application/json")
	self.__data = data


func status(status: int) -> void:
	self.__status = status
