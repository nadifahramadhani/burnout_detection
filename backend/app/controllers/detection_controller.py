from app.models.detection import Detection
from app.models.journal import Journal
from app.models.lifestyle import Lifestyle


class DetectionController:

    @staticmethod
    def _build_detection_item(detection):
        journal = Journal.query.get(detection.journal_id)
        lifestyle = Lifestyle.query.filter_by(journal_id=detection.journal_id).first()

        return {
            **detection.to_dict(),
            'journal': journal.to_dict() if journal else None,
            'lifestyle': {
                'sleep_hours': float(lifestyle.sleep_hours) if lifestyle else 0,
                'exercise_minute': lifestyle.exercise_minute if lifestyle else 0,
                'study_hours_per_day': float(lifestyle.study_hours_per_day) if lifestyle else 0,
                'breaks_per_day': lifestyle.breaks_per_day if lifestyle else 0,
                'coffee_intake_mg': lifestyle.coffee_intake_mg if lifestyle else 0
            },
        }

    @staticmethod
    def get_by_id(user_id, detection_id):
        detection = Detection.query.filter_by(
            detection_id=detection_id,
            user_id=user_id
        ).first()

        if not detection:
            return None

        return DetectionController._build_detection_item(detection)

    @staticmethod
    def get_latest_by_user(user_id):
        detection = Detection.query.filter_by(user_id=user_id)\
            .order_by(Detection.created_at.desc())\
            .first()

        if not detection:
            return None

        return DetectionController._build_detection_item(detection)

    @staticmethod
    def get_all_by_user(user_id, page=1, per_page=10):
        query = Detection.query.filter_by(user_id=user_id)

        total = query.count()
        detections = query.order_by(Detection.created_at.desc())\
            .offset((page - 1) * per_page)\
            .limit(per_page)\
            .all()

        data = [DetectionController._build_detection_item(detection) for detection in detections]

        return data, total
