from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_jwt_extended import JWTManager
import os

db = SQLAlchemy()
jwt = JWTManager()


def create_app(config_name=None):
    app = Flask(__name__)
    
    if config_name is None:
        config_name = os.getenv('FLASK_ENV', 'development')
    
    from app.config import get_config
    config = get_config(config_name)
    app.config.from_object(config)
    
    db.init_app(app)
    jwt.init_app(app)
    CORS(app, resources={r"/api/*": {"origins": app.config['CORS_ORIGINS']}})
    
    from app.routes import (
        auth_routes,
        lifestyle_routes,
        journal_routes,
        detection_routes,
        history_routes,
        profile_routes
    )
    
    app.register_blueprint(auth_routes.bp)
    app.register_blueprint(lifestyle_routes.bp)
    app.register_blueprint(journal_routes.bp)
    app.register_blueprint(detection_routes.bp)
    app.register_blueprint(history_routes.bp)
    app.register_blueprint(profile_routes.bp)
    
    from app.models import user, lifestyle, journal, detection

    with app.app_context():
        db.create_all()
    
    @app.errorhandler(404)
    def not_found(error):
        return {
            'success': False,
            'message': 'Resource not found',
            'error': str(error)
        }, 404
    
    @app.errorhandler(500)
    def internal_error(error):
        db.session.rollback()
        return {
            'success': False,
            'message': 'Internal server error',
            'error': str(error) if app.debug else 'An error occurred'
        }, 500
    
    @app.route('/api/health', methods=['GET'])
    def health_check():
        return {
            'success': True,
            'message': 'API is running',
            'environment': config_name
        }, 200
    
    return app