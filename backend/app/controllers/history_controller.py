# app/controllers/history_controller.py
from app.models.detection import Detection
from app.models.journal import Journal
from datetime import datetime


class HistoryController:

    @staticmethod
    def get_history(user_id, month=None, year=None):
        query = Detection.query.filter_by(user_id=user_id)

        # Filter
        if month and year:
            from sqlalchemy import extract
            query = query.filter(
                extract('month', Detection.created_at) == month,
                extract('year', Detection.created_at) == year
            )

        detections = query.order_by(Detection.created_at.desc()).all()

        result = []
        for d in detections:
            journal = Journal.query.get(d.journal_id)
            result.append({
                'detection_id': d.detection_id,
                'date': d.created_at.isoformat(),
                'burnout_level': d.burnout_level,
                'burnout_score': float(d.burnout_score) if d.burnout_score else 0,
                'prob_normal': float(d.prob_normal) if d.prob_normal else 0,
                'prob_rendah': float(d.prob_rendah) if d.prob_rendah else 0,
                'prob_sedang': float(d.prob_sedang) if d.prob_sedang else 0,
                'prob_tinggi': float(d.prob_tinggi) if d.prob_tinggi else 0,
                'jurnaling': {
                    'text_jurnal': journal.text_jurnal if journal else '',
                    'mood': journal.mood if journal else ''
                }
            })

        return result

    @staticmethod
    def get_history_by_date(user_id, date_str):
        """Ambil deteksi pada tanggal tertentu"""
        try:
            target_date = datetime.strptime(date_str, '%Y-%m-%d').date()
        except ValueError:
            return []

        detections = Detection.query.filter_by(user_id=user_id).all()
        result = []
        for d in detections:
            if d.created_at.date() == target_date:
                journal = Journal.query.get(d.journal_id)
                result.append({
                    'detection_id': d.detection_id,
                    'date': d.created_at.isoformat(),
                    'burnout_level': d.burnout_level,
                    'burnout_score': float(d.burnout_score) if d.burnout_score else 0,
                    'jurnaling': {
                        'text_jurnal': journal.text_jurnal if journal else '',
                        'mood': journal.mood if journal else ''
                    }
                })
        return result
