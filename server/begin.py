from getpass import getpass
CLARIFAI_PAT = getpass()
from langchain.llms import Clarifai
from langchain import PromptTemplate, LLMChain
template = """Question: {question}

Answer: Give me ten. Inlcude a link to these book on amazon and return them in json format"""

prompt = PromptTemplate(template=template, input_variables=["question"])
USER_ID = "openai"
APP_ID = "chat-completion"
MODEL_ID = "GPT-3_5-turbo"
clarifai_llm = Clarifai(
    pat=CLARIFAI_PAT, user_id=USER_ID, app_id=APP_ID, model_id=MODEL_ID
)
llm_chain = LLMChain(prompt=prompt, llm=clarifai_llm)
question = "What book title would a person who likes cooking like to read?"
print(llm_chain.run(question))
        