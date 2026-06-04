"""
Response Helper
Standardized JSON response wrapper
"""
from flask import jsonify


def success_response(message='Success', data=None, status_code=200):
    """
    Create standardized success response
    
    Args:
        message: str - Success message
        data: dict/list - Response data
        status_code: int - HTTP status code (default: 200)
    
    Returns:
        tuple - (JSON response, status code)
    """
    response = {
        'success': True,
        'message': message,
    }
    
    if data is not None:
        response['data'] = data
    
    return jsonify(response), status_code


def error_response(message='Error', error=None, status_code=400):
    """
    Create standardized error response
    
    Args:
        message: str - Error message
        error: str/dict - Error details
        status_code: int - HTTP status code (default: 400)
    
    Returns:
        tuple - (JSON response, status code)
    """
    response = {
        'success': False,
        'message': message,
    }
    
    if error is not None:
        response['error'] = error
    
    return jsonify(response), status_code


def paginated_response(data, total, page, per_page, message='Success', status_code=200):
    """
    Create paginated response
    
    Args:
        data: list - Response data
        total: int - Total items
        page: int - Current page
        per_page: int - Items per page
        message: str - Success message
        status_code: int - HTTP status code
    
    Returns:
        tuple - (JSON response, status code)
    """
    response = {
        'success': True,
        'message': message,
        'data': data,
        'pagination': {
            'total': total,
            'page': page,
            'per_page': per_page,
            'total_pages': (total + per_page - 1) // per_page
        }
    }
    
    return jsonify(response), status_code