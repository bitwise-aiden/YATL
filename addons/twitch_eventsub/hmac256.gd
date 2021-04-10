class_name Hmac

# Enums
enum Types { MD5 = 0, SHA1, SHA256 }


# Constant variables
const BLOCK_SIZE = 64


# Private variables
var __key: PoolByteArray = []
var __message: PoolByteArray = []
var __type: int = 2


# Lifecycle methods
func _init(type: int, key: String) -> void:
	self.__type = type
	self.__key = key.to_utf8()


# Public methods
func digest() -> String:
	if self.__key.size() > BLOCK_SIZE:
		self.__key = self.__sha(self.__key)

	while self.__key.size() < BLOCK_SIZE:
		self.__key.append(0)

	var o_key_pad: PoolByteArray = PoolByteArray([])
	var i_key_pad: PoolByteArray = PoolByteArray([])

	for i in BLOCK_SIZE:
		o_key_pad.append(self.__key[i] ^ 0x5c)
		i_key_pad.append(self.__key[i] ^ 0x36)

	# H(key || H(key || message))
	var result = self.__sha(i_key_pad + self.__message)
	result = self.__sha(o_key_pad + result)

	return result.hex_encode()


func update(message: String) -> void:
	self.__message = message.to_utf8()


func __sha(content: PoolByteArray) -> PoolByteArray:
	var context: HashingContext = HashingContext.new()

	context.start(self.__type)
	context.update(content)

	return context.finish()
