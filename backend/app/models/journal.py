from app import db
from datetime import datetime

class Journal(db.Model):
    """Journal model — tabel jurnal (catatan harian siswa)"""
    __tablename__ = 'journals'
    
    journal_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False, index=True)
    text_journal = db.Column(db.Text, nullable=False)
    mood = db.Column(db.Enum('Senang', 'Biasa Aja', 'Sedih', 'Marah'), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    detections = db.relationship('Detection', backref='journal', lazy=True)
    
    def __repr__(self):
        return f'<Journal user_id={self.user_id} mood={self.mood}>'
    
    def to_dict(self):
        return {
            'journal_id': self.journal_id,
            'user_id': self.user_id,
            'text_journal': self.text_journal,
            'mood': self.mood,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
