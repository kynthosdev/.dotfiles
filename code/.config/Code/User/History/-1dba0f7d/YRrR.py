from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

from preprocessors.ncs import raw

import pandas as pd 

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/ncs/raw/")
async def get_nc_raw_data(file: UploadFile):
    data = await raw(file.file)

    return JSONResponse(content=data)