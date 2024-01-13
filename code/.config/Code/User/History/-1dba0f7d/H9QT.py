from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

import pandas as pd 

app = FastAPI()

csv = './test_files/ncwtasks_2022_to_Nov2023.csv'

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/ncs/raw/")
async def get_json_data():
    df = pd.DataFrame(
        [["Canada", 10], ["USA", 20]], 
        columns=["team", "points"]
    )
    return df.to_dict(orient="records")