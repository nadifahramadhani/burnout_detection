# app/controllers/journal_controller.py
from app import db
from app.models.journal import Journal
from app.models.lifestyle import Lifestyle
from app.models.detection import Detection
from app.controllers.lifestyle_controller import LifestyleController
import numpy as np


class JournalController:

    @staticmethod
    def create_journal_with_detection(user_id, text_jurnal, mood, lifestyle_data):
        """
        Alur utama UC03:
        1. Simpan jurnal
        2. Simpan lifestyle (linked ke journal)
        3. Jalankan ML pipeline
        4. Simpan hasil deteksi
        5. Return hasil
        """
        from app.ml.nlp_pipeline import get_nlp_pipeline
        from app.ml.gmm_model import get_gmm_model
        from app.ml.xgboost_model import get_xgboost_model

        # Step 1: Simpan jurnal ke DB
        journal = Journal(
            user_id=user_id,
            text_journal=text_jurnal,
            mood=mood
        )
        db.session.add(journal)
        db.session.flush()  # dapatkan journal_id tanpa commit

        # Step 2: Simpan lifestyle data (linked ke journal_id)
        lifestyle = LifestyleController.create_lifestyle(
            user_id=user_id,
            data=lifestyle_data,
            journal_id=journal.journal_id
        )

        # Step 3: NLP Pipeline — teks → vektor
        nlp = get_nlp_pipeline()
        text_vector = nlp.pipeline(text_jurnal)  # shape: (n,)

        # Step 4: Susun array lifestyle numerik
        lifestyle_array = np.array([
            lifestyle_data.get('study_hours_per_day', 0),
            lifestyle_data.get('sleep_hours', 0),
            lifestyle_data.get('exercise_minute', 0),
            lifestyle_data.get('breaks_per_day', 0),
            lifestyle_data.get('coffee_intake_mg', 0)
        ], dtype=float)

        # Step 5: Build Super Matrix (gabung vektor teks + lifestyle)
        xgb = get_xgboost_model()
        super_matrix = xgb.build_super_matrix(text_vector, lifestyle_array)

        # Step 6: GMM — dapatkan probabilitas cluster
        gmm = get_gmm_model()
        gmm_probs = gmm.get_probabilities(super_matrix)

        # Step 7: XGBoost — prediksi final burnout level
        burnout_level, burnout_score = xgb.predict(super_matrix, gmm_probs)

        # Step 8: Simpan hasil deteksi ke DB
        detection = Detection(
            user_id=user_id,
            journal_id=journal.journal_id,
            burnout_level=burnout_level,
            burnout_score=burnout_score,
            prob_normal=float(gmm_probs[0]) if len(gmm_probs) > 0 else 0.0,
            prob_rendah=float(gmm_probs[1]) if len(gmm_probs) > 1 else 0.0,
            prob_sedang=float(gmm_probs[2]) if len(gmm_probs) > 2 else 0.0,
            prob_tinggi=float(gmm_probs[3]) if len(gmm_probs) > 3 else 0.0,
        )
        db.session.add(detection)
        db.session.commit()

        return journal, detection

    @staticmethod
    def get_journal_by_id(journal_id, user_id):
        return Journal.query.filter_by(
            journal_id=journal_id,
            user_id=user_id
        ).first()
