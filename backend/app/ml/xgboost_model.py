# app/ml/xgboost_model.py
import joblib
import numpy as np
from flask import current_app

LABEL_MAP = {
    0: 'Aman dan Sehat',
    1: 'Mulai Penat',
    2: 'Burnout Sedang',
    3: 'Burnout Berat'
}

class XGBoostModel:
    _model = None
    _scaler = None

    def __init__(self):
        self._load_models()

    def _load_models(self):
        try:
            xgb_path = current_app.config.get('XGBOOST_MODEL_PATH', 'saved_models/model_xgboost.pkl')
            scaler_path = current_app.config.get('SCALER_LIFESTYLE_PATH', 'saved_models/scaler_lifestyle.pkl')

            self._model = joblib.load(xgb_path)
            self._scaler = joblib.load(scaler_path)
            print(f"[XGBoost] Model loaded: {xgb_path}")
        except Exception as e:
            print(f"[XGBoost] ERROR loading model: {e}")
            raise

    def build_super_matrix(self, text_vector: np.ndarray, lifestyle_array: np.ndarray) -> np.ndarray:
        lifestyle_scaled = self._scaler.transform(lifestyle_array.reshape(1, -1))

        super_matrix = np.concatenate([
            text_vector.flatten(),
            lifestyle_scaled.flatten()
        ])
        return super_matrix

    def predict(self, super_matrix: np.ndarray) -> tuple:
        prediction = self._model.predict(super_matrix.reshape(1, -1))
        label = int(prediction[0])
        burnout_level = LABEL_MAP.get(label, 'Aman dan Sehat')

        if hasattr(self._model, 'predict_proba'):
            proba = self._model.predict_proba(super_matrix.reshape(1, -1))[0]
            burnout_score = float(np.max(proba) * 100)
        else:
            proba = [0.0, 0.0, 0.0, 0.0]
            burnout_score = float(label / 3 * 100)

        return burnout_level, burnout_score, proba

_xgboost_model = None

def get_xgboost_model():
    global _xgboost_model
    if _xgboost_model is None:
        _xgboost_model = XGBoostModel()
    return _xgboost_model