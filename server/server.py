from flask import Flask, request, jsonify
from prompt import getRec
from objects import Book
import json
import base64

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

    recommended_books = getRec(prompt) #recommend_books_for_user(past_books)  # Replace with your recommendation logic


    return recommended_books
@app.route('/upload', methods=['POST'])
def upload_content():
    data = request.json

    user_id = data.get('accID')
    filename = data.get('filename')
    content_base64 = data.get('content')

    if not user_id or not filename or not content_base64:
        return jsonify({'error': 'userID, filename, and content are required'}), 400

    save_content(user_id, filename, content_base64)

    return jsonify({'message': 'Content uploaded successfully'})

def save_content(user_id, filename, content_base64):
    # In a real application, you would save the content to a file or database
    # For demonstration purposes, we'll just print the decoded content here
    print(f"Content for user {user_id}, filename {filename}:\n{content_base64}")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)

