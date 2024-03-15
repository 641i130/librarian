import requests


def isbn_lookup(isbn):
    "Searching isbn requst to pull information"
    url = "https://openlibrary.org/search.json?q=" + str(isbn)
    response = requests.get(url)
    if response.status_code == 200:
        # Parse the HTML content
        d = response.json()
        if d['numFound'] != 0:
            title = d['docs'][0]['title']
            print(title)

isbn_lookup("9784088906713")
