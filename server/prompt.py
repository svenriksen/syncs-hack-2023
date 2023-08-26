from objects import User,Book
import settings,os
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_KEY",default="")
from langchain import PromptTemplate, LLMChain
import json
template = """Question: {question}.give me 2 book names and link on amazon. Return the name of the books and the url of each book on amazon in a json list.
Answer: Short and to the point. """
from langchain.llms import OpenAI

prompt = PromptTemplate(template=template, input_variables=["question"])

openai_llm = OpenAI()

llm_chain = LLMChain(prompt=prompt, llm=openai_llm)

def getRec(prompt : str):
    a = llm_chain.run(prompt)
    return a

if __name__ == "__main__":
    question = "What book title would a person who likes cooking like to read?"
    # run chain and store result
    print(getRec(question))
