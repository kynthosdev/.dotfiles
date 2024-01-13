async def export_data():
    # Create a sample dataframe
    df = pd.DataFrame({'col1': [1, 2], 'col2': [3, 4]})
    stream = io.StringIO()
    df.to_csv(stream, index=False)
    response = StreamingResponse(
        iter([stream.getvalue()]), media_type="text/csv")
    response.headers["Content-Disposition"] = "attachment; filename=export.csv"
    return response