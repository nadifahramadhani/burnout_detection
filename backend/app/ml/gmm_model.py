# app/ml/gmm_model.py
import joblib
import numpy as np
from flask import current_app


class GMMModel:

    _model = None
    _scaler = None

    def __init__(self):
        self._load_models()

    def _load_models(self):
        try:
            gmm_path = current_app.config.get('GMM_MODEL_PATH', 'saved_models/model_gmm.pkl')
            scaler_path = current_app.config.get('SCALER_GMM_PATH', 'saved_models/scaler_gmm.pkl')

            self._model = joblib.load(gmm_path)
            self._scaler = joblib.load(scaler_path)
            print(f"[GMM] Model loaded: {gmm_path}")
        except Exception as e:
            print(f"[GMM] ERROR loading model: {e}")
            raise

    def get_probabilities(self, super_matrix: np.ndarray) -> np.ndarray:
        scaled = self._scaler.transform(super_matrix.reshape(1, -1))

        probs = self._model.predict_proba(scaled)
        return probs[0] 

    def pseudo_label(self, super_matrix: np.ndarray) -> int:
        scaled = self._scaler.transform(super_matrix.reshape(1, -1))
        return int(self._model.predict(scaled)[0])


_gmm_model = None

def get_gmm_model():
    global _gmm_model
    if _gmm_model is None:
        _gmm_model = GMMModel()
    return _gmm_model
