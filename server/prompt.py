from objects import User,Book
import settings
CLARIFAI_PAT = settings.OPENAI_API_KEY
from langchain.llms import Clarifai
from langchain import PromptTemplate, LLMChain
import re
import json
template = """Question: {question}
Additional information, these are books that users have read, it might have ratings on a scale of 10 (1 is the lowest and 10 is the highest). Please based on the book that they read, how many times they read them, and their ratings for the book to better evalute your reccommendation of books. Below are the books
{books}

Answer: Short and to the point. Give me 10 and link on amazon. Please return the name of the books and the url of each book on amazon in json and store it in the variable called books."""

prompt = PromptTemplate(template=template, input_variables=["question", "books"])
USER_ID = "openai" #info about model
APP_ID = "chat-completion"
MODEL_ID = "GPT-3_5-turbo"

clarifai_llm = Clarifai(
    pat=CLARIFAI_PAT, user_id=USER_ID, app_id=APP_ID, model_id=MODEL_ID
)

llm_chain = LLMChain(prompt=prompt, llm=clarifai_llm)

def getRec(prompt : str, books):
    a = llm_chain.run({'question':prompt, 'books':books})
    print(a)
    a = json.loads(a)
    print(a)
    json.dumps(a,indent=2)
    print(a)
    return a

if __name__ == "__main__":
    question = "What book title would a person who likes cooking like to read? return the name of the books and the url of each book on amazon in json."
    # run chain and store result
    print(getRec(question))
