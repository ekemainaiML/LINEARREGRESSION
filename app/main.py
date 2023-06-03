from fastapi import FastAPI
from pydantic import BaseModel
from app.model.model import predict_pipeline

__version__ = "0.1.0"
app = FastAPI()


class DataIn(BaseModel):
    Iy: float
    PF: float
    e:  float
    dIf: float
    
class PredictionOut(BaseModel):
    If: float


@app.get("/")
def home():
    return {"health_check": "OK", "model_version": __version__}


@app.post("/predict", response_model=PredictionOut)
def predict(payload: DataIn):
    excitationCurrent = predict_pipeline(payload)
    return {"excitationCurrent": excitationCurrent}