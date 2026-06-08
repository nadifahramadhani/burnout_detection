# app/routes/detection_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models.detection import Detection
from app.models.journal import Journal
from app.utils.response import success_response, error_response

bp = Blueprint('detection', __name__, url_prefix='/api/detection')


@bp.route('/<int:detection_id>', methods=['GET'])
@jwt_required()
def get_detection(detection_id):
    """
    GET /api/detection/<detection_id>
    Ambil detail hasil deteksi tertentu
    """
    try:
        user_id = get_jwt_identity()
        detection = Detection.query.filter_by(
            detection_id=detection_id,
            user_id=user_id
        ).first()

        if not detection:
            return error_response('Deteksi tidak ditemukan', status_code=404)

        journal = Journal.query.get(detection.journal_id)
        result = {
            **detection.to_dict(),
            'journal': journal.to_dict() if journal else None
        }

        return success_response('Deteksi berhasil diambil', data=result)

    except Exception as e:
        return error_response('Gagal mengambil deteksi', str(e), 500)


@bp.route('/latest', methods=['GET'])
@jwt_required()
def get_latest_detection():
    """
    GET /api/detection/latest
    Ambil hasil deteksi terbaru user
    """
    try:
        user_id = get_jwt_identity()
        detection = Detection.query.filter_by(user_id=user_id)\
                                   .order_by(Detection.created_at.desc())\
                                   .first()

        if not detection:
            return error_response('Belum ada hasil deteksi', status_code=404)

        journal = Journal.query.get(detection.journal_id)
        result = {
            **detection.to_dict(),
            'journal': journal.to_dict() if journal else None
        }

        return success_response('Deteksi terbaru berhasil diambil', data=result)

    except Exception as e:
        return error_response('Gagal mengambil deteksi', str(e), 500)
