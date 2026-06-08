# app/controllers/profile_controller.py
from app import db
from app.models.user import User


class ProfileController:

    @staticmethod
    def get_profile(user_id):
        return User.query.get(user_id)

    @staticmethod
    def update_profile(user_id, data):
        """Update profil — sesuai class diagram: updateProfile()"""
        user = User.query.get(user_id)
        if not user:
            return None, 'User tidak ditemukan', 404

        if data.get('first_name'):
            user.first_name = data['first_name']
        if data.get('last_name'):
            user.last_name = data['last_name']
        if data.get('age'):
            user.age = data['age']
        if data.get('gender'):
            user.gender = data['gender']

        db.session.commit()
        return user, 'Profil berhasil diperbarui', 200
