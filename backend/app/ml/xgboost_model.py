# app/ml/xgboost_model.py
import joblib
import numpy as np
from flask import current_app


# Mapping label ke burnout level (sesuai ERD ENUM)
LABEL_MAP = {
    0: 'Normal',
    1: 'Rendah',
    2: 'Sedang',
    3: 'Tinggi'
}


class XGBoostModel:
    """
    XGBoost Classifier untuk prediksi final burnout level
    Input: super_matrix + gmm_probabilities
    Output: burnout_level (string), burnout_score (float)
    """

    _model = None
    _scaler = None

    def __init__(self):
        self._load_models()

    def _load_models(self):
        """Load XGBoost model dan scaler lifestyle dari .pkl"""
        try:
            xgb_path = current_app.config.get(
                'XGBOOST_MODEL_PATH', 'saved_models/model_xgboost.pkl'
            )
            scaler_path = current_app.config.get(
                'SCALER_LIFESTYLE_PATH', 'saved_models/scaler_lifestyle.pkl'
            )

            self._model = joblib.load(xgb_path)
            self._scaler = joblib.load(scaler_path)
            print(f"[XGBoost] Model loaded: {xgb_path}")
        except Exception as e:
            print(f"[XGBoost] ERROR loading model: {e}")
            raise

    def build_super_matrix(self, text_vector: np.ndarray,
                            lifestyle_array: np.ndarray) -> np.ndarray:
        """
        Bangun Super Matrix:
        Gabungkan vektor teks (FastText) + data numerik pola hidup
        Sesuai sequence UC03: Proses Super Matrix()
        """
        # Scale lifestyle data
        lifestyle_scaled = self._scaler.transform(lifestyle_array.reshape(1, -1))

        # Concatenate: [text_vector | lifestyle_scaled]
        super_matrix = np.concatenate([
            text_vector.flatten(),
            lifestyle_scaled.flatten()
        ])
        return super_matrix

    def predict(self, super_matrix: np.ndarray,
                gmm_probs: np.ndarray) -> tuple:
        """
        Prediksi burnout level dengan XGBoost
        Input: super_matrix + probabilitas GMM
        Output: (burnout_level: str, burnout_score: float)
        """
        # Gabungkan super_matrix dengan GMM probabilities
        final_input = np.concatenate([
            super_matrix.flatten(),
            gmm_probs.flatten()
        ])

        # Prediksi
        prediction = self._model.predict(final_input.reshape(1, -1))
        label = int(prediction[0])
        burnout_level = LABEL_MAP.get(label, 'Normal')

        # Score: ambil probability kelas tertinggi sebagai confidence score
        if hasattr(self._model, 'predict_proba'):
            proba = self._model.predict_proba(final_input.reshape(1, -1))
            burnout_score = float(np.max(proba) * 100)
        else:
            burnout_score = float(label / 3 * 100)

        return burnout_level, burnout_score


# Singleton
_xgboost_model = None

def get_xgboost_model():
    global _xgboost_model
    if _xgboost_model is None:
        _xgboost_model = XGBoostModel()
    return _xgboost_model
