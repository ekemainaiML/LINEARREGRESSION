from fastapi import FastAPI
from app.model import DataIn, PredictionOut, predict_pipeline, __version__

app = FastAPI()


@app.get("/")
def home():
    return {"health_check": "OK", "model_version": __version__}


@app.post("/predict", response_model=PredictionOut)
def predict(payload: DataIn):
    If = predict_pipeline([[payload.Iy, payload.PF, payload.e, payload.dIf]])
    return {"If": If}