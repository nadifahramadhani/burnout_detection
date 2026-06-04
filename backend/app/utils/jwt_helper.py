"""
JWT Helper Utilities
Functions for JWT token creation and verification
"""
from flask_jwt_extended import create_access_token, get_jwt_identity
from flask import current_app
from functools import wraps
from flask import jsonify


def create_jwt_token(user_id, email, additional_claims=None):
    """
    Create JWT access token for a user
    
    Args:
        user_id: int - User ID
        email: str - User email
        additional_claims: dict - Additional data to include in token
    
    Returns:
        str - JWT token
    """
    claims = {
        'user_id': user_id,
        'email': email
    }
    
    if additional_claims:
        claims.update(additional_claims)
    
    token = create_access_token(
        identity=user_id,
        additional_claims=claims
    )
    
    return token


def token_required(f):
    """
    Decorator to require valid JWT token
    
    Usage:
        @token_required
        def protected_route():
            user_id = get_jwt_identity()
            ...
    """
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
    """Get current user ID from JWT token"""
    return get_jwt_identity()