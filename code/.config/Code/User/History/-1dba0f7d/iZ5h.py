from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse, StreamingResponse

import pandas as pd 

app = FastAPI()

csv = './test_files/ncwtasks_2022_to_Nov2023.csv'

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/ncs/raw/")
def get_csv_data():
    df = pd.DataFrame(
        [["Canada", 10], ["USA", 20]], 
        columns=["team", "points"]
    )
    return StreamingResponse(
        iter([df.to_csv(index=False)]),
        media_type="text/csv",
        headers={"Content-Disposition": f"attachment; filename=data.csv"}
)