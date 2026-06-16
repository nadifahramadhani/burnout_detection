# app/routes/auth_routes.py
from flask import Blueprint, request
from flask_jwt_extended import get_jwt, jwt_required
from app.controllers.auth_controller import AuthController
from app.utils.response import success_response, error_response

bp = Blueprint('auth', __name__, url_prefix='/api/auth')


@bp.route('/register', methods=['POST'])
def register():
    try:
        data = request.get_json()

        required = ['first_name', 'last_name', 'email', 'password', 'password_confirm']
        for field in required:
            if not data.get(field):
                return error_response(f'Field {field} wajib diisi', status_code=400)

        if len(data['password']) < 6:
            return error_response('Password minimal 6 karakter', status_code=400)

        if data['password'] != data['password_confirm']:
            return error_response('Password dan konfirmasi password tidak cocok', status_code=400)

        user, message, status = AuthController.register(
            first_name=data['first_name'],
            last_name=data['last_name'],
            email=data['email'],
            password=data['password'],
            password_confirm=data['password_confirm'],
            age=data.get('age'),
            gender=data.get('gender')
        )

        if not user:
            return error_response(message, status_code=status)

        return success_response(message, data=user.to_dict(), status_code=status)

    except Exception as e:
        return error_response('Registrasi gagal', str(e), 500)


@bp.route('/login', methods=['POST'])
def login():
    try:
        data = request.get_json()

        if not data.get('email') or not data.get('password'):
            return error_response('Email dan password wajib diisi', status_code=400)

        user, token, message, status = AuthController.login(
            email=data['email'],
            password=data['password']
        )

        if not user:
            return error_response(message, status_code=status)

        return success_response(message, data={
            'token': token,
            'user': user.to_dict()
        }, status_code=status)

    except Exception as e:
        return error_response('Login gagal', str(e), 500)


@bp.route('/logout', methods=['POST'])
@jwt_required()
def logout():
    try:
        message, status = AuthController.logout(get_jwt())
        return success_response(message, status_code=status)

    except Exception as e:
        return error_response('Logout gagal', str(e), 500)
