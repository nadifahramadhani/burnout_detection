# app/controllers/profile_controller.py
from app import db
from app.models.user import User


class ProfileController:

    @staticmethod
    def get_profile(user_id):
        return User.query.get(user_id)

    @staticmethod
    def update_profile(user_id, data):
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
    
    @staticmethod
    def change_password(user_id, old_password, new_password, confirm_new_password):
        user = User.query.get(user_id)
        if not user:
            return None, 'User tidak ditemukan', 404

        if not old_password or not new_password or not confirm_new_password:
            return None, 'Semua field password (lama, baru, konfirmasi) harus diisi', 400

        if not user.check_password(old_password):
            return None, 'Password lama salah', 400

        if new_password != confirm_new_password:
            return None, 'Password baru dan konfirmasi tidak cocok', 400
            
        if len(new_password) < 6:
            return None, 'Password baru minimal 6 karakter', 400

        user.set_password(new_password)
        db.session.commit()

        return user, 'Password berhasil diperbarui', 200
