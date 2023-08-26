from objects import User,Book
import settings,os
os.environ["OPENAI_API_KEY"] = settings.OPENAI_API_KEY
from langchain.llms import Clarifai
from langchain import PromptTemplate, LLMChain
import json
template = """Question: {question}
These are books that users have read,. Please based on the book that they read, how many times they read them, and their ratings for the book to better evalute your reccommendation of books. Below are the books
{books}

Answer: Short and to the point. Give me 10 and link on amazon. Please return the name of the books and the url of each book on amazon in json"""
from langchain.llms import OpenAI

prompt = PromptTemplate(template=template, input_variables=["question", "books"])

openai_llm = OpenAI()

llm_chain = LLMChain(prompt=prompt, llm=openai_llm)

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
    print(getRec(question,[]))
