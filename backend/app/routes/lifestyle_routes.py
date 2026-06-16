# app/routes/lifestyle_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.lifestyle_controller import LifestyleController
from app.utils.response import success_response, error_response, paginated_response

bp = Blueprint('lifestyle', __name__, url_prefix='/api/lifestyle')


@bp.route('', methods=['GET'])
@jwt_required()
def get_lifestyles():
    try:
        user_id = get_jwt_identity()
        page = max(request.args.get('page', 1, type=int), 1)
        per_page = min(max(request.args.get('per_page', 10, type=int), 1), 100)

        lifestyles, total = LifestyleController.get_all_by_user(user_id, page, per_page)
        data = [lifestyle.to_dict() for lifestyle in lifestyles]

        return paginated_response(data, total, page, per_page, 'Data pola hidup berhasil diambil')

    except Exception as e:
        return error_response('Gagal mengambil data pola hidup', str(e), 500)


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
