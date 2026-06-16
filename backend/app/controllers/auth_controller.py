# app/controllers/auth_controller.py
from app import db
from datetime import datetime
from app.models.user import User
from app.models.token_blacklist import TokenBlacklist
from app.utils.jwt_helper import create_jwt_token


class AuthController:

    @staticmethod
    def register(first_name, last_name, email, password, password_confirm, age=None, gender=None):
        if not password or len(password) < 6:
            return None, 'Password minimal 6 karakter', 400
        
        if password != password_confirm:
            return None, 'Password dan konfirmasi password tidak cocok', 400

        existing_user = User.query.filter_by(email=email).first()
        if existing_user:
            return None, 'Email sudah terdaftar', 409

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

    @staticmethod
    def logout(jwt_data):
        jti = jwt_data['jti']
        user_id = jwt_data.get('user_id')
        expires_at = datetime.utcfromtimestamp(jwt_data['exp'])

        if TokenBlacklist.is_jti_blacklisted(jti):
            return 'Token sudah logout', 200

        token_blacklist = TokenBlacklist(
            jti=jti,
            user_id=user_id,
            expires_at=expires_at
        )

        db.session.add(token_blacklist)
        db.session.commit()

        return 'Logout berhasil', 200
