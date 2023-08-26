from objects import User,Book
from getpass import getpass
CLARIFAI_PAT = getpass()
from langchain.llms import Clarifai
from langchain import PromptTemplate, LLMChain
template = """Question: {question}
Answer: Short and to the point. Give me 10 and link on amazon."""

prompt = PromptTemplate(template=template, input_variables=["question"])
USER_ID = "openai" #info about model
APP_ID = "chat-completion"
MODEL_ID = "GPT-3_5-turbo"

clarifai_llm = Clarifai(
    pat=CLARIFAI_PAT, user_id=USER_ID, app_id=APP_ID, model_id=MODEL_ID
)

llm_chain = LLMChain(prompt=prompt, llm=clarifai_llm)
question = "What book title would a person who likes cooking like to read? return the name of the books and the url of each book on amazon in json."
# run chain and store result
result = llm_chain.run(question)
print(result)