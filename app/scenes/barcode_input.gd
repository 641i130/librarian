extends TextEdit

# Import the Book class
const Book = preload("res://scenes/Book.gd")
var books = [] # Array of books

func _ready():
	# Connect the text_changed signal to the _on_text_changed function
	self.grab_focus()
	# TODO
	# LOAD BOOKS BACK IN FROM THE SAVE FILE

# Save function
func save_books(books: Array) -> void:
	var file = FileAccess.open("user://data.csv", FileAccess.WRITE | FileAccess.READ)
	if file != null:
		# Serialize each book and save to file
		for book in books:
			var serialized_book = {
				"title": book.title,
				"author": book.author,
				"barcode": book.barcode,
				"count": book.count
			}
			file.store_line(to_json(serialized_book))
		file.close()

# Load function
# Get load and save functions to save list of books, then work on book lookups using get requests and HTML parsing...
func load_books() -> Array:
	var books = []
	var file = FileAccess.open("user://data.csv", FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			if line.strip_edges() != ""systey :
				# Deserialize each line and create Book object
				var serialized_book = parse_json(line)
				var book = Book.new()
				book.title = serialized_book["title"]
				book.author = serialized_book["author"]
				book.year = serialized_book["year"]
				books.append(book)
		file.close()
	return books


func spawn_book(code):
	"Spawns a book record"
	code = code.replace("\n","")
	if code != "":
		# Update or create book
		# check if book in list
		for book in books:
			if code == book.barcode:
				book.count+=1
				book.update_count()
				return
		var booker = Book.new(code)
		books.append(booker)
		get_node("/root/Main/CanvasLayer/ScrollBox/List").add_child(booker.draw())

func _on_text_changed():
	# Check if the last character is a newline character
	if text.ends_with("\n"):
		# Make queue of book record
		spawn_book(self.text)
		# Clear the TextEdit
		clear()

func _process(delta):
	pass
