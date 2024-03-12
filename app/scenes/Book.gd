extends FlowContainer

class_name Book

# Properties
var title: String
var author: String
var barcode: String
var count: int = 1
var book = load("res://scenes/book_record.tscn")

# Constructor
func _init(barcode: String) -> void:
	self.title = ""
	self.author = ""
	self.barcode = barcode
	self.count = 1
	
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
	return book
