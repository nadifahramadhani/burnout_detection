# app/routes/detection_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.detection_controller import DetectionController
from app.utils.response import success_response, error_response, paginated_response

bp = Blueprint('detection', __name__, url_prefix='/api/detection')


@bp.route('', methods=['GET'])
@jwt_required()
def get_detections():
    try:
        user_id = get_jwt_identity()
        page = max(request.args.get('page', 1, type=int), 1)
        per_page = min(max(request.args.get('per_page', 10, type=int), 1), 100)

        detections, total = DetectionController.get_all_by_user(user_id, page, per_page)

        return paginated_response(detections, total, page, per_page, 'Deteksi berhasil diambil')

    except Exception as e:
        return error_response('Gagal mengambil deteksi', str(e), 500)


@bp.route('/<int:detection_id>', methods=['GET'])
@jwt_required()
def get_detection(detection_id):
    try:
        user_id = get_jwt_identity()
        detection = DetectionController.get_by_id(user_id, detection_id)

        if not detection:
            return error_response('Deteksi tidak ditemukan', status_code=404)

        return success_response('Deteksi berhasil diambil', data=detection)

    except Exception as e:
        return error_response('Gagal mengambil deteksi', str(e), 500)


@bp.route('/latest', methods=['GET'])
@jwt_required()
def get_latest_detection():
    try:
        user_id = get_jwt_identity()
        detection = DetectionController.get_latest_by_user(user_id)

        if not detection:
            return error_response('Belum ada hasil deteksi', status_code=404)

        return success_response('Deteksi terbaru berhasil diambil', data=detection)

    except Exception as e:
        return error_response('Gagal mengambil deteksi', str(e), 500)
