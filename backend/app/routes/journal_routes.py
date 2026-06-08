# app/routes/journal_routes.py
from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.controllers.journal_controller import JournalController
from app.utils.response import success_response, error_response

bp = Blueprint('journal', __name__, url_prefix='/api/journal')


@bp.route('', methods=['POST'])
@jwt_required()
def create_journal():
    """
    POST /api/journal
    Headers: Authorization: Bearer <token>
    Body: {
        text_jurnal: string,
        mood: "Senang"|"Biasa Aja"|"Sedih"|"Marah",
        pola_hidup: {
            study_hours_per_day, sleep_hours,
            exercise_minute, breaks_per_day, coffee_intake_mg
        }
    }
    Returns: { journal, detection_result }
    Sesuai sequence UC03
    """
    try:
        user_id = get_jwt_identity()
        data = request.get_json()

        # Validasi field wajib
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

        # Jalankan create + deteksi
        journal, detection = JournalController.create_journal_with_detection(
            user_id=user_id,
            text_jurnal=data['text_jurnal'],
            mood=data['mood'],
            lifestyle_data=pola_hidup
        )

        # Response sesuai sequence UC03: 200 OK (level, score)
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
