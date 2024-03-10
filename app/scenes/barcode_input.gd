extends TextEdit

# Import the Book class
const Book = preload("res://scenes/Book.gd")
var books = [] # Array of books

func _ready():
	# Connect the text_changed signal to the _on_text_changed function
	self.grab_focus()
	# TODO
	# LOAD BOOKS BACK IN FROM THE SAVE FILE

func save(content,count):
	pass

func data_load():
	pass

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
