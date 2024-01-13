import io
from fastapi.responses import StreamingResponse
import pandas as pd


async def export_data(df):
    stream = io.StringIO()
    
    df.to_csv(stream, index=False)
    response = StreamingResponse(
        iter([stream.getvalue()]), media_type="text/csv")
    response.headers["Content-Disposition"] = "attachment; filename=export.csv"
    
    return response