from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

from preprocessors import ncs

import pandas as pd 

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/ncs/raw/")
async def get_nc_raw_data(file: UploadFile):
    data = await ncs.raw(file.file)
    data.to_json(orient='records')
    
    return JSONResponse(content=data)