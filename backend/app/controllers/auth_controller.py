# app/controllers/auth_controller.py
from app import db
from app.models.user import User
from app.utils.jwt_helper import create_jwt_token


class AuthController:

    @staticmethod
    def register(first_name, last_name, email, password, password_confirm, age=None, gender=None):
        # Validasi password tidak kosong
        if not password or len(password) < 6:
            return None, 'Password minimal 6 karakter', 400
        
        # Validasi password dan konfirmasi cocok
        if password != password_confirm:
            return None, 'Password dan konfirmasi password tidak cocok', 400

        # Cek email
        existing_user = User.query.filter_by(email=email).first()
        if existing_user:
            return None, 'Email sudah terdaftar', 409

        # Buat user baru
        user = User(
            first_name=first_name,
            last_name=last_name,
            email=email,
            age=age,
            gender=gender
        )
        user.set_password(password)

        db.session.add(user)
        db.session.commit()

        return user, 'Registrasi berhasil', 201

    @staticmethod
    def login(email, password):
        user = User.query.filter_by(email=email).first()

        if not user or not user.check_password(password):
            return None, None, 'Email atau password salah', 401

        token = create_jwt_token(user.user_id, user.email)

        return user, token, 'Login berhasil', 200
