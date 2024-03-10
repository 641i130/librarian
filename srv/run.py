from flask import Flask, request, jsonify

app = Flask(__name__)

# Mock data for demonstration purposes
book_data = {
    "1234567890": {
        "title": "Sample Book",
        "author": "John Doe",
        "image_url": "https://example.com/book-image"
    }
}

@app.route('/isbn', methods=['GET'])
def get_book_details():
    isbn = request.args.get('isbn')
    if isbn in book_data:
        return jsonify(book_data[isbn])
    else:
        return jsonify({"error": "Book not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)

