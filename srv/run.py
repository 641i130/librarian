from flask import Flask, request, jsonify

app = Flask(__name__)

# Mock data for demonstration purposes
book_data = {
    "9780064471107": {
        "title": "The Magician's Nephew",
        "author": "C. S. Lewis",
        "image_url": "https://images.isbndb.com/covers/11/07/9780064471107.jpg"
    }
}

@app.route('/isbn', methods=['POST'])
def get_book_details():
    data = request.get_json()
    barcode = data.get('barcode')
    
    if barcode in book_data:
        return jsonify(book_data[barcode])
    else:
        return jsonify({"error": "Not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)

