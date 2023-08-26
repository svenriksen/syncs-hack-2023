from flask import Flask, request, jsonify
from prompt import getRec
from objects import Book
import json

app = Flask(__name__)

# Sample data - replace this with your own data source or database
user_profiles = {}

@app.route('/recommend', methods=['POST'])
def recommend_books():
    data = request.json

    acc_id = data.get('accID')
    prompt = data.get('prompt')
    past_books = Book.combineBooks(data.get('pastBooks', []))

    print(f'Incoming request from {acc_id}. Given prompt: "{prompt}"')
    print((past_books))
    if not acc_id or not prompt:
        return jsonify({'error': 'Account ID and prompt are required'}), 400

    user_profiles[acc_id] = {
        'prompt': prompt,
        'past_books': past_books
    }

    recommended_books = getRec(prompt,past_books) #recommend_books_for_user(past_books)  # Replace with your recommendation logic


    return recommended_books

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)

