# app/routes/profile_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.profile_controller import ProfileController
from app.utils.response import success_response, error_response

bp = Blueprint('profile', __name__, url_prefix='/api/profile')


@bp.route('', methods=['GET'])
@jwt_required()
def get_profile():
    """
    GET /api/profile
    Ambil profil user yang sedang login
    """
    try:
        user_id = get_jwt_identity()
        user = ProfileController.get_profile(user_id)

        if not user:
            return error_response('User tidak ditemukan', status_code=404)

        return success_response('Profil berhasil diambil', data=user.to_dict())

    except Exception as e:
        return error_response('Gagal mengambil profil', str(e), 500)


@bp.route('', methods=['PUT'])
@jwt_required()
def update_profile():
    """
    PUT /api/profile
    Update profil user
    Body: { first_name, last_name, age, gender }
    """
    try:
        user_id = get_jwt_identity()
        data = request.get_json()

        user, message, status = ProfileController.update_profile(user_id, data)

        if not user:
            return error_response(message, status_code=status)

        return success_response(message, data=user.to_dict(), status_code=status)

    except Exception as e:
        return error_response('Gagal mengupdate profil', str(e), 500)
