from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

from preprocessors.ncs import raw

import pandas as pd 

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/ncs/raw/")
async def get_json_data():
    data = await raw()
    
    return JSONResponse(content=data)