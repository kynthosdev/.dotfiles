from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

from preprocessors import ncs.ra

import pandas as pd 

app = FastAPI()


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