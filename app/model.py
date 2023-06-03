from pathlib import Path
import pickle
import sklearn
import re

__version__ = "0.1.0"

BASE_DIR = Path(__file__).resolve(strict=True).parent

with open(f"{BASE_DIR}/best_gs_model_{__version__}.pkl", "rb") as f:
    model = pickle.load(f)

def predict_pipeline(data):
   
    pred = model.predict([data])
    return pred