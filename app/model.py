from pathlib import Path
import pickle
import sklearn
import re

__version__ = "0.1.0"

BASE_DIR = Path(__file__).resolve(strict=True).parent

with open(f"{BASE_DIR}/best_gs_model_{__version__}.pkl", "rb") as f:
    model = pickle.load(f)

def predict_pipeline(data):
    data = data.dict()
    Iy = data["Iy"]
    PF = data["PF"]
    e = data["e"]
    dIf = data["dIf"]
    pred = model.predict([[Iy, PF, e, dIf]])
    return pred