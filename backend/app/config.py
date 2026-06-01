import os
from datetime import timedelta
from dotenv import load_dotenv

# Load environment variables dari .env
load_dotenv()

class Config:
    """Base Configuration"""
    # Flask
    FLASK_ENV = os.getenv('FLASK_ENV', 'development')
    DEBUG = os.getenv('FLASK_DEBUG', True)
    
    # Database
    DB_HOST = os.getenv('DB_HOST', 'localhost')
    DB_PORT = os.getenv('DB_PORT', 3306)
    DB_USER = os.getenv('DB_USER', 'root')
    DB_PASSWORD = os.getenv('DB_PASSWORD', '')
    DB_NAME = os.getenv('DB_NAME', 'burnout_detection_db')
    
    # SQLAlchemy Configuration
    SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://root:password@localhost/db_burnout_detection"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = True  # Log SQL queries (debug)
    
    # JWT Configuration
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'daumCd9jvpRJcIwaeLyVJiwlaALCTRojVfpIvcWF6To')
    JWT_ALGORITHM = os.getenv('JWT_ALGORITHM', 'HS256')
    JWT_ACCESS_TOKEN_EXPIRES = int(os.getenv('JWT_ACCESS_TOKEN_EXPIRES', 3600))  # 1 hour
    
    # API Configuration
    API_HOST = os.getenv('API_HOST', '127.0.0.1')
    API_PORT = int(os.getenv('API_PORT', 5000))
    
    # CORS Configuration
    CORS_ORIGINS = os.getenv('CORS_ORIGINS', '*').split(',')
    
    # Machine Learning Models Path
    MODELS_PATH = os.getenv('MODELS_PATH', 'saved_models/')
    GMM_MODEL_PATH = os.getenv('GMM_MODEL_PATH', 'saved_models/model_gmm.pkl')
    XGBOOST_MODEL_PATH = os.getenv('XGBOOST_MODEL_PATH', 'saved_models/model_xgboost.pkl')
    FASTTEXT_MODEL_PATH = os.getenv('FASTTEXT_MODEL_PATH', 'saved_models/fasttext_burnout_model.bin')
    SCALER_GMM_PATH = os.getenv('SCALER_GMM_PATH', 'saved_models/scaler_gmm.pkl')
    SCALER_LIFESTYLE_PATH = os.getenv('SCALER_LIFESTYLE_PATH', 'saved_models/scaler_lifestyle.pkl')


class DevelopmentConfig(Config):
    """Development Configuration"""
    DEBUG = True
    TESTING = False


class ProductionConfig(Config):
    """Production Configuration"""
    DEBUG = False
    TESTING = False
    # Matikan SQL echo di production
    SQLALCHEMY_ECHO = False


class TestingConfig(Config):
    """Testing Configuration"""
    DEBUG = True
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'  # Use in-memory database for testing


# Dictionary untuk switch config
config_dict = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}

# Get active config
def get_config(env=None):
    if env is None:
        env = os.getenv('FLASK_ENV', 'development')
    return config_dict.get(env, DevelopmentConfig)