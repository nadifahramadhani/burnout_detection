from flask import jsonify


def success_response(message='Success', data=None, status_code=200):
    response = {
        'success': True,
        'message': message,
    }
    
    if data is not None:
        response['data'] = data
    
    return jsonify(response), status_code


def error_response(message='Error', error=None, status_code=400):
    response = {
        'success': False,
        'message': message,
    }
    
    if error is not None:
        response['error'] = error
    
    return jsonify(response), status_code


def paginated_response(data, total, page, per_page, message='Success', status_code=200):
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