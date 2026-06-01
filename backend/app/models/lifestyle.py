from app import db
from datetime import datetime

class Lifestyle(db.Model):
    """Lifestyle model — tabel lifestyle (pola hidup harian)"""
    __tablename__ = 'lifestyles'
    
    lifestyle_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False, index=True)
    journal_id = db.Column(db.Integer, db.ForeignKey('journals.journal_id'), nullable=True)
    
    study_hours_per_day = db.Column(db.Float(precision=2), nullable=False)
    sleep_hours = db.Column(db.Float(precision=2), nullable=False)
    exercise_minute = db.Column(db.Integer, nullable=False)
    breaks_per_day = db.Column(db.SmallInteger, nullable=False)
    coffee_intake_mg = db.Column(db.Integer, nullable=False)
    
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<Lifestyle user_id={self.user_id} created_at={self.created_at}>'
    
    def to_dict(self):
        return {
            'lifestyle_id': self.lifestyle_id,
            'user_id': self.user_id,
            'journal_id': self.journal_id,
            'study_hours_per_day': self.study_hours_per_day,
            'sleep_hours': self.sleep_hours,
            'exercise_minute': self.exercise_minute,
            'breaks_per_day': self.breaks_per_day,
            'coffee_intake_mg': self.coffee_intake_mg,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }