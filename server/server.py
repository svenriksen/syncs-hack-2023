from flask import Flask, request, jsonify
from prompt import getRec
import json

app = Flask(__name__)

# Sample data - replace this with your own data source or database
user_profiles = {}

@app.route('/recommend', methods=['POST'])
def recommend_books():
    data = request.json

    acc_id = data.get('accID')
    prompt = data.get('prompt')
    past_books = data.get('pastBooks', [])

    print(f'Incoming request from {acc_id}. Given prompt: "{prompt}"')
    for b in past_books:
        print(f'''---
name: {b.get("name")}
read {b.get("nread")} times
ratings given: {b.get("ratings")}
''')

    if not acc_id or not prompt:
        return jsonify({'error': 'Account ID and prompt are required'}), 400

    user_profiles[acc_id] = {
        'prompt': prompt,
        'past_books': past_books
    }

    recommended_books = getRec(prompt) #recommend_books_for_user(past_books)  # Replace with your recommendation logic


    return recommended_books

def recommend_books_for_user(past_books):
    # Replace this with your recommendation logic
    # You can use the past_books information to make recommendations based on reading history and ratings
    # Return a list of recommended books with their details
    recommended_books = past_books
    return recommended_books

if __name__ == '__main__':
    app.run(debug=True)

