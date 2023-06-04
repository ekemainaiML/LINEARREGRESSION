from pathlib import Path
import pickle
import sklearn
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

def predict_pipeline(data):
    pred = model.predict(data)
    return pred