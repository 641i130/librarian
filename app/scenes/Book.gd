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
func _init(code: String) -> void:
	self.title = ""
	self.author = ""
	self.url = ""
	self.barcode = code
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

# TODO write get set functions of the book object to save the values when needed

# Save image to users local cache and set the URL value accordingly
func save_img():
	if self.url == "":
		book.img(url)
		var file ="user://covers/" + self.barcode + ".jpg"
		book.get_node("IMG").texture.save_jpg(file,1.0)
		print(file)
		self.url = file

# Returns node to add as child to list
func draw():
	book = book.instantiate()
	book.get_node("Box/Info/Barcode").text = self.barcode
	if book.get_node("Box/Info/Title").text == "": # If the book wasn't generated before
		book.get_node("Box/Info/Title").text = "Title: "
		book.get_node("Box/Info/Author").text = "Author: "
		book.get_node("Box/Info/Count").text = str(self.count)
	else:
		book.get_node("Box/Info/Title").text = self.title
		book.get_node("Box/Info/Author").text = self.author
		book.get_node("Box/Info/Count").text = str(self.count)
	return book # Once this is returned the object then calls its _ready and we can call the get request
