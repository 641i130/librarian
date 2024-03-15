extends FlowContainer

class_name Book

# Properties
var title: String
var author: String
var barcode: String
var url: String
var count: int = 1
var book = load("res://scenes/book_record.tscn")

# Constructor
func _init(barcode: String) -> void:
	self.title = ""
	self.author = ""
	self.url = ""
	self.barcode = barcode
	self.count = 1

# Returns book in json format
func out():
	return {
			"title": book.get_node("Box/Info/Title").text,
			"author": book.get_node("Box/Info/Author").text,
			"barcode": book.get_node("Box/Info/Barcode").text,
			"count": self.count,
			"url": self.url,
		}

func update_count():
	book.get_node("Box/Info/Count").text = str(self.count)

# Returns node to add as child to list
func draw():
	book = book.instantiate()
	book.get_node("Box/Info/Barcode").text = self.barcode
	# Using the code we should retrieve other info about book and import
	# We can add toggles for specific book engines later
	book.get_node("Box/Info/Title").text = "Title: "
	book.get_node("Box/Info/Author").text = "Author: "
	book.get_node("Box/Info/Count").text = str(self.count)
	return book # Once this is returned the object then calls its _ready and we can call the get request
