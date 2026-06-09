# app/routes/lifestyle_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.lifestyle_controller import LifestyleController
from app.utils.response import success_response, error_response

bp = Blueprint('lifestyle', __name__, url_prefix='/api/lifestyle')


@bp.route('', methods=['POST'])
@jwt_required()
def create_lifestyle():
    try:
        user_id = get_jwt_identity()
        data = request.get_json()

        required = ['study_hours_per_day', 'sleep_hours']
        for field in required:
            if data.get(field) is None:
                return error_response(f'Field {field} wajib diisi', status_code=400)

        lifestyle = LifestyleController.create_lifestyle(user_id, data)
        return success_response('Data pola hidup berhasil disimpan',
                                data=lifestyle.to_dict(), status_code=201)

    except Exception as e:
        return error_response('Gagal menyimpan data pola hidup', str(e), 500)


@bp.route('/latest', methods=['GET'])
@jwt_required()
def get_latest():
    try:
        user_id = get_jwt_identity()
        lifestyle = LifestyleController.get_latest_by_user(user_id)

        if not lifestyle:
            return error_response('Belum ada data pola hidup', status_code=404)

        return success_response('Data pola hidup terbaru', data=lifestyle.to_dict())

    except Exception as e:
        return error_response('Gagal mengambil data', str(e), 500)
