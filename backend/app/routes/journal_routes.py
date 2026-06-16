from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.journal_controller import JournalController
from app.utils.response import success_response, error_response, paginated_response

bp = Blueprint('journal', __name__, url_prefix='/api/journal')


@bp.route('', methods=['GET'])
@jwt_required()
def get_journals():
    try:
        user_id = get_jwt_identity()
        page = max(request.args.get('page', 1, type=int), 1)
        per_page = min(max(request.args.get('per_page', 10, type=int), 1), 100)

        journals, total = JournalController.get_all_by_user(user_id, page, per_page)
        data = [journal.to_dict() for journal in journals]

        return paginated_response(data, total, page, per_page, 'Jurnal berhasil diambil')

    except Exception as e:
        return error_response('Gagal mengambil jurnal', str(e), 500)


@bp.route('', methods=['POST'])
@jwt_required()
def create_journal():
   
    try:
        user_id = get_jwt_identity()
        data = request.get_json()

        if not data.get('text_jurnal'):
            return error_response('Teks jurnal wajib diisi', status_code=400)
        if not data.get('mood'):
            return error_response('Mood wajib dipilih', status_code=400)

        mood_valid = ['Senang', 'Biasa Aja', 'Sedih', 'Marah']
        if data['mood'] not in mood_valid:
            return error_response(f'Mood harus salah satu dari: {mood_valid}', status_code=400)

        pola_hidup = data.get('pola_hidup', {})
        if not pola_hidup.get('study_hours_per_day') or not pola_hidup.get('sleep_hours'):
            return error_response('Data pola hidup (jam belajar & tidur) wajib diisi', status_code=400)

        journal, detection = JournalController.create_journal_with_detection(
            user_id=user_id,
            text_jurnal=data['text_jurnal'],
            mood=data['mood'],
            lifestyle_data=pola_hidup
        )

        return success_response('Jurnal berhasil disimpan dan deteksi selesai', data={
            'journal': journal.to_dict(),
            'hasil_deteksi': {
                'burnout_level': detection.burnout_level,
                'burnout_score': detection.burnout_score,
                'prob_normal': detection.prob_normal,
                'prob_rendah': detection.prob_rendah,
                'prob_sedang': detection.prob_sedang,
                'prob_tinggi': detection.prob_tinggi,
            }
        }, status_code=200)

    except Exception as e:
        return error_response('Gagal memproses jurnal', str(e), 500)
