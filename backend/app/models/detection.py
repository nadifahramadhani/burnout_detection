from app import db
from datetime import datetime

class Detection(db.Model):
    """Detection model — hasil deteksi burnout dari GMM dan XGBoost"""
    __tablename__ = 'detections'
    
    detection_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False, index=True)
    journal_id = db.Column(db.Integer, db.ForeignKey('journals.journal_id'), nullable=False, index=True)
    
    # Burnout Level (dari kombinasi model)
    burnout_level = db.Column(db.Enum('Aman dan Sehat', 'Mulai Penat', 'Burnout Sedang', 'Burnout Berat'), nullable=False)
    burnout_score = db.Column(db.Numeric(precision=5, scale=2), nullable=False)
    
    # Probabilitas dari GMM (sebelum input lifestyle)
    prob_normal = db.Column(db.Numeric(precision=6, scale=4), nullable=False)
    prob_rendah = db.Column(db.Numeric(precision=6, scale=4), nullable=False)
    prob_sedang = db.Column(db.Numeric(precision=6, scale=4), nullable=False)
    prob_tinggi = db.Column(db.Numeric(precision=6, scale=4), nullable=False)
    
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<Detection user_id={self.user_id} level={self.burnout_level}>'
    
    def to_dict(self):
        return {
            'detection_id': self.detection_id,
            'user_id': self.user_id,
            'journal_id': self.journal_id,
            'burnout_level': self.burnout_level,
            'burnout_score': float(self.burnout_score) if self.burnout_score else 0,
            'prob_normal': float(self.prob_normal) if self.prob_normal else 0,
            'prob_rendah': float(self.prob_rendah) if self.prob_rendah else 0,
            'prob_sedang': float(self.prob_sedang) if self.prob_sedang else 0,
            'prob_tinggi': float(self.prob_tinggi) if self.prob_tinggi else 0,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }