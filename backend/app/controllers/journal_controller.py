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
        from app.ml.nlp_pipeline import get_nlp_pipeline
        from app.ml.xgboost_model import get_xgboost_model

        journal = Journal(
            user_id=user_id,
            text_jurnal=text_jurnal,
            mood=mood
        )
        db.session.add(journal)
        db.session.flush()  


        lifestyle = LifestyleController.create_lifestyle(
            user_id=user_id,
            data=lifestyle_data,
            journal_id=journal.journal_id
        )

        nlp = get_nlp_pipeline()
        text_vector = nlp.pipeline(text_jurnal)

        lifestyle_array = np.array([
            float(lifestyle_data.get('sleep_hours', 0)),
            float(lifestyle_data.get('study_hours_per_day', 0)),
            float(lifestyle_data.get('exercise_minute', 0))
        ])

        xgb = get_xgboost_model()
        super_matrix = xgb.build_super_matrix(text_vector, lifestyle_array)

        burnout_level, burnout_score, xgb_probs = xgb.predict(super_matrix)

        detection = Detection(
            user_id=user_id,
            journal_id=journal.journal_id,
            burnout_level=burnout_level,
            burnout_score=burnout_score,
            prob_normal=float(xgb_probs[0]) * 100 if len(xgb_probs) > 0 else 0.0,
            prob_rendah=float(xgb_probs[1]) * 100 if len(xgb_probs) > 1 else 0.0,
            prob_sedang=float(xgb_probs[2]) * 100 if len(xgb_probs) > 2 else 0.0,
            prob_tinggi=float(xgb_probs[3]) * 100 if len(xgb_probs) > 3 else 0.0,
        )
        db.session.add(detection)
        db.session.commit()

        return journal, detection, lifestyle

    @staticmethod
    def get_journal_by_id(journal_id, user_id):
        return Journal.query.filter_by(
            journal_id=journal_id,
            user_id=user_id
        ).first()

    @staticmethod
    def get_all_by_user(user_id, page=1, per_page=10):
        query = Journal.query.filter_by(user_id=user_id)

        total = query.count()
        journals = query.order_by(Journal.created_at.desc())\
            .offset((page - 1) * per_page)\
            .limit(per_page)\
            .all()

        return journals, total
