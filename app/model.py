from pathlib import Path
import pickle
import sklearn
import re
from pydantic import BaseModel

__version__ = "0.1.0"

BASE_DIR = Path(__file__).resolve(strict=True).parent

with open(f"{BASE_DIR}/best_gs_model_{__version__}.pkl", "rb") as f:
    model = pickle.load(f)

class DataIn(BaseModel):
    Iy: float
    PF: float
    e:  float
    dIf: float
    
class PredictionOut(BaseModel):
    If: float

def predict_pipeline(data: DataIn):
    data = data.dict()
    Iy = data["Iy"]
    PF = data["PF"]
    e = data["e"]
    dIf = data["dIf"]
    pred = model.predict([[Iy, PF, e, dIf]])
    return pred