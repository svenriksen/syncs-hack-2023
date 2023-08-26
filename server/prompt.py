import os

PAT = os.getenv("CLARIFAI_KEY")
USER_ID = 'openai'
APP_ID = 'chat-completion'
MODEL_ID = 'GPT-3_5-turbo'
MODEL_VERSION_ID = '8ea3880d08a74dc0b39500b99dfaa376'
TEXT_FILE_URL = './request.txt'

from clarifai_grpc.channel.clarifai_channel import ClarifaiChannel
from clarifai_grpc.grpc.api import resources_pb2, service_pb2, service_pb2_grpc
from clarifai_grpc.grpc.api.status import status_code_pb2


channel = ClarifaiChannel.get_grpc_channel()
stub = service_pb2_grpc.V2Stub(channel)

metadata = (('authorization', 'Key ' + PAT),)

userDataObject = resources_pb2.UserAppIDSet(user_id=USER_ID, app_id=APP_ID)

def getRec(prompt : str):
    prompt = f"""Question: {prompt}
Answer: Give me 5 books and amazon link in json list the following format"""
    post_model_outputs_response = stub.PostModelOutputs(
        service_pb2.PostModelOutputsRequest(
            user_app_id=userDataObject,  # The userDataObject is created in the overview and is required when using a PAT
            model_id=MODEL_ID,
            version_id=MODEL_VERSION_ID,  # This is optional. Defaults to the latest model version
            inputs=[
                resources_pb2.Input(
                    data=resources_pb2.Data(
                        text=resources_pb2.Text(
                            raw=prompt
                        )
                    )
                )
            ]
        ),
        metadata=metadata
    )
    if post_model_outputs_response.status.code != status_code_pb2.SUCCESS:
        
        raise Exception(f"Post model outputs failed, status: {post_model_outputs_response.status.code}")

    # Since we have one input, one output will exist here
    output = post_model_outputs_response.outputs[0]
    return output.data.text.raw

if __name__ == "__main__":
    print("Completion:\n")
    print(getRec("find me books on cooking fish"))
