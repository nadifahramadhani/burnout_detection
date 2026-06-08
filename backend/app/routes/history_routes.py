# app/routes/history_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.history_controller import HistoryController
from app.utils.response import success_response, error_response

bp = Blueprint('history', __name__, url_prefix='/api/history')


@bp.route('', methods=['GET'])
@jwt_required()
def get_history():
    """
    GET /api/history?view=monthly&month=6&year=2026
    Sesuai sequence UC04: GET/history(user_id=&view=monthly)
    Returns: list deteksi + data jurnal per bulan (kalender, list entri)
    """
    try:
        user_id = get_jwt_identity()
        view = request.args.get('view', 'all')
        month = request.args.get('month', type=int)
        year = request.args.get('year', type=int)

        history = HistoryController.get_history(user_id, month, year)

        return success_response('Riwayat berhasil diambil', data={
            'total': len(history),
            'history': history
        })

    except Exception as e:
        return error_response('Gagal mengambil riwayat', str(e), 500)


@bp.route('/date', methods=['GET'])
@jwt_required()
def get_history_by_date():
    """
    GET /api/history/date?date=2026-06-01
    """
    try:
        user_id = get_jwt_identity()
        date_str = request.args.get('date')

        if not date_str:
            return error_response('Parameter date wajib diisi (format: YYYY-MM-DD)', status_code=400)

        history = HistoryController.get_history_by_date(user_id, date_str)
        return success_response('Riwayat berhasil diambil', data=history)

    except Exception as e:
        return error_response('Gagal mengambil riwayat', str(e), 500)
