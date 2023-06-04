from fastapi import FastAPI
from app.model import DataIn, PredictionOut, predict_pipeline, __version__

app = FastAPI()


@app.get("/")
def home():
    return {"health_check": "OK", "model_version": __version__}


@app.post("/predict", response_model=PredictionOut)
def predict(payload: DataIn):
    payload = payload.__dict__()
    Iy = payload["Iy"]
    PF = payload["PF"]
    e = payload["e"]
    dIf = payload["dIf"]
    If = predict_pipeline([[Iy, PF, e, dIf]])
    return If