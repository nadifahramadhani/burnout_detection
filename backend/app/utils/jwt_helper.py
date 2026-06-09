from flask_jwt_extended import create_access_token, get_jwt_identity
from flask import current_app
from functools import wraps
from flask import jsonify


def create_jwt_token(user_id, email, additional_claims=None):
    claims = {
        'user_id': user_id,
        'email': email
    }
    
    if additional_claims:
        claims.update(additional_claims)
    
    token = create_access_token(
        identity=str(user_id), 
        additional_claims=claims
    )
    
    return token


def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        try:
            user_id = get_jwt_identity()
            return f(*args, **kwargs)
        except Exception as e:
            return {
                'success': False,
                'message': 'Invalid or missing token',
                'error': str(e)
            }, 401
    
    return decorated


def get_current_user_id():
    user_id_string = get_jwt_identity()
    return int(user_id_string)