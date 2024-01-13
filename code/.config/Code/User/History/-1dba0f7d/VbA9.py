from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

from preprocessors import ncs

import pandas as pd
import helpers


app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/ncs/raw/")
async def get_nc_raw_data(file: UploadFile):
    data = await ncs.raw(file.file)

    return JSONResponse(content=data.to_json(orient='records'))


@app.post("/ncs/rawfile/")
async def get_nc_raw_data_file(file: UploadFile):
    
    data = await ncs.raw(file.file)
    response = helpers.export_data(data)

    return response