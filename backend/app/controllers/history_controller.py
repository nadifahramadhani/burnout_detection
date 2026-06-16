# app/controllers/history_controller.py
from app.models.detection import Detection
from app.models.journal import Journal
from app.models.lifestyle import Lifestyle
from datetime import datetime


class HistoryController:

    @staticmethod
    def _build_history_item(detection):
        journal = Journal.query.get(detection.journal_id)
        lifestyle = Lifestyle.query.filter_by(journal_id=detection.journal_id).first()

        return {
            'detection_id': detection.detection_id,
            'journal_id': detection.journal_id,
            'tanggal': detection.created_at.isoformat() if detection.created_at else None,
            'date': detection.created_at.isoformat() if detection.created_at else None,
            'mood': journal.mood if journal else None,
            'curhatan': journal.text_jurnal if journal else '',
            'burnout_level': detection.burnout_level,
            'burnout_score': float(detection.burnout_score) if detection.burnout_score is not None else 0,
            'lifestyle': {
                'sleep_hours': float(lifestyle.sleep_hours) if lifestyle else 0,
                'exercise_minute': lifestyle.exercise_minute if lifestyle else 0,
                'study_hours_per_day': float(lifestyle.study_hours_per_day) if lifestyle else 0,
                'breaks_per_day': lifestyle.breaks_per_day if lifestyle else 0,
                'coffee_intake_mg': lifestyle.coffee_intake_mg if lifestyle else 0
            },
            'probabilitas': {
                'normal': float(detection.prob_normal) if detection.prob_normal is not None else 0,
                'rendah': float(detection.prob_rendah) if detection.prob_rendah is not None else 0,
                'sedang': float(detection.prob_sedang) if detection.prob_sedang is not None else 0,
                'tinggi': float(detection.prob_tinggi) if detection.prob_tinggi is not None else 0
            }
        }

    @staticmethod
    def get_history(user_id, month=None, year=None, page=1, per_page=10):
        query = Detection.query.filter_by(user_id=user_id)

        if month and year:
            from sqlalchemy import extract
            query = query.filter(
                extract('month', Detection.created_at) == month,
                extract('year', Detection.created_at) == year
            )

        total = query.count()
        detections = query.order_by(Detection.created_at.desc())\
            .offset((page - 1) * per_page)\
            .limit(per_page)\
            .all()

        history = [HistoryController._build_history_item(detection) for detection in detections]

        return history, total

    @staticmethod
    def get_history_by_date(user_id, date_str, page=1, per_page=10):
        try:
            target_date = datetime.strptime(date_str, '%Y-%m-%d').date()
        except ValueError:
            return [], 0

        from sqlalchemy import func

        query = Detection.query.filter_by(user_id=user_id)\
            .filter(func.date(Detection.created_at) == target_date)

        total = query.count()
        detections = query.order_by(Detection.created_at.desc())\
            .offset((page - 1) * per_page)\
            .limit(per_page)\
            .all()

        history = [HistoryController._build_history_item(detection) for detection in detections]

        return history, total
