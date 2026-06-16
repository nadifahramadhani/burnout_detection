# app/routes/history_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.history_controller import HistoryController
from app.utils.response import error_response, paginated_response

bp = Blueprint('history', __name__, url_prefix='/api/history')


@bp.route('', methods=['GET'])
@jwt_required()
def get_history():
    try:
        user_id = get_jwt_identity()
        view = request.args.get('view', 'all')
        month = request.args.get('month', type=int)
        year = request.args.get('year', type=int)
        page = max(request.args.get('page', 1, type=int), 1)
        per_page = min(max(request.args.get('per_page', 10, type=int), 1), 100)

        history, total = HistoryController.get_history(user_id, month, year, page, per_page)

        return paginated_response(history, total, page, per_page, 'Riwayat berhasil diambil')

    except Exception as e:
        return error_response('Gagal mengambil riwayat', str(e), 500)


@bp.route('/date', methods=['GET'])
@jwt_required()
def get_history_by_date():
    try:
        user_id = get_jwt_identity()
        date_str = request.args.get('date')
        page = max(request.args.get('page', 1, type=int), 1)
        per_page = min(max(request.args.get('per_page', 10, type=int), 1), 100)

        if not date_str:
            return error_response('Parameter date wajib diisi (format: YYYY-MM-DD)', status_code=400)

        history, total = HistoryController.get_history_by_date(user_id, date_str, page, per_page)
        return paginated_response(history, total, page, per_page, 'Riwayat berhasil diambil')

    except Exception as e:
        return error_response('Gagal mengambil riwayat', str(e), 500)
