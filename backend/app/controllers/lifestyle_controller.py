# app/controllers/lifestyle_controller.py
from app import db
from app.models.lifestyle import Lifestyle


class LifestyleController:

    @staticmethod
    def create_lifestyle(user_id, data, journal_id=None):
        lifestyle = Lifestyle(
            user_id=user_id,
            journal_id=journal_id,
            study_hours_per_day=data.get('study_hours_per_day', 0),
            sleep_hours=data.get('sleep_hours', 0),
            exercise_minute=data.get('exercise_minute', 0),
            breaks_per_day=data.get('breaks_per_day', 0),
            coffee_intake_mg=data.get('coffee_intake_mg', 0)
        )
        db.session.add(lifestyle)
        db.session.commit()
        return lifestyle

    @staticmethod
    def get_latest_by_user(user_id):
        return Lifestyle.query.filter_by(user_id=user_id)\
                              .order_by(Lifestyle.created_at.desc())\
                              .first()

    @staticmethod
    def get_all_by_user(user_id, page=1, per_page=10):
        query = Lifestyle.query.filter_by(user_id=user_id)

        total = query.count()
        lifestyles = query.order_by(Lifestyle.created_at.desc())\
            .offset((page - 1) * per_page)\
            .limit(per_page)\
            .all()

        return lifestyles, total
