# app/ml/nlp_pipeline.py
import re
import joblib
import numpy as np
import fasttext
from flask import current_app


class NLPPipeline:
    """
    Pipeline NLP sesuai laporan:
    1. Preprocessing: lowercase, regex cleansing, stopword removal
    2. Vektorisasi: FastText word vectors
    """

    _instance = None
    _model = None

    # Stopword Indonesia dasar
    STOPWORDS = {
        'yang', 'dan', 'di', 'ke', 'dari', 'ini', 'itu', 'dengan',
        'untuk', 'pada', 'adalah', 'tidak', 'ada', 'juga', 'saya',
        'aku', 'kamu', 'dia', 'kami', 'kita', 'mereka', 'atau',
        'karena', 'jadi', 'sudah', 'akan', 'bisa', 'lebih', 'sangat',
        'ya', 'si', 'lah', 'pun', 'nya'
    }

    def __init__(self):
        self._load_model()

    def _load_model(self):
        """Load FastText model dari file .bin"""
        try:
            model_path = current_app.config.get(
                'FASTTEXT_MODEL_PATH',
                'saved_models/fasttext_burnout_model.bin'
            )
            self._model = fasttext.load_model(model_path)
            print(f"[NLP] FastText model loaded from {model_path}")
        except Exception as e:
            print(f"[NLP] ERROR loading FastText model: {e}")
            raise

    def preprocess(self, text: str) -> str:
        """
        Tahap preprocessing sesuai laporan:
        1. Lowercase
        2. Regex cleansing (hapus karakter non-alfanumerik)
        3. Stopword removal
        """
        # 1. Lowercase
        text = text.lower()

        # 2. Regex cleansing — hapus karakter selain huruf dan spasi
        text = re.sub(r'[^\w\s]', ' ', text)
        text = re.sub(r'\d+', ' ', text)
        text = re.sub(r'\s+', ' ', text).strip()

        # 3. Stopword removal
        tokens = text.split()
        tokens = [t for t in tokens if t not in self.STOPWORDS and len(t) > 1]

        return ' '.join(tokens)

    def tokenize(self, text: str) -> list:
        """Tokenisasi teks setelah preprocessing"""
        return text.split()

    def vectorize(self, text: str) -> np.ndarray:
        """
        Konversi teks menjadi vektor menggunakan FastText
        FastText menghitung rata-rata vektor semua kata
        """
        processed = self.preprocess(text)
        if not processed:
            return np.zeros(self._model.get_dimension())

        vector = self._model.get_sentence_vector(processed)
        return vector

    def pipeline(self, text: str) -> np.ndarray:
        """
        Jalankan full pipeline: text → vektor
        Dipanggil oleh detection_controller
        """
        return self.vectorize(text)


# Singleton loader — inisiasi satu kali saat app startup
_nlp_pipeline = None

def get_nlp_pipeline():
    """Get atau inisialisasi NLP pipeline singleton"""
    global _nlp_pipeline
    if _nlp_pipeline is None:
        _nlp_pipeline = NLPPipeline()
    return _nlp_pipeline
