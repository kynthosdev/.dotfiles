import io
from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse, StreamingResponse

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
    stream = io.StringIO()
    
    df.to_csv(stream, index=False)
    response = StreamingResponse(
        iter([stream.getvalue()]), media_type="text/csv")
    response.headers["Content-Disposition"] = "attachment; filename=export.csv"


    return response