import os
from datetime import timedelta
from dotenv import load_dotenv

load_dotenv()

class Config:
    # Flask
    FLASK_ENV = os.getenv('FLASK_ENV', 'development')
    DEBUG = os.getenv('FLASK_DEBUG', 'True') == 'True'
    
    # Database Credentials
    DB_HOST = os.getenv('DB_HOST', 'localhost')
    DB_PORT = os.getenv('DB_PORT', 3306)
    DB_USER = os.getenv('DB_USER', 'root')
    DB_PASSWORD = os.getenv('DB_PASSWORD', '')
    DB_NAME = os.getenv('DB_NAME', 'db_burnout_detection')
    
    SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = True  # Log SQL queries (debug)
    
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY')
    
    # Validasi Keamanan Ekstrem: Matikan aplikasi jika Secret Key tidak ada di .env!
    if not JWT_SECRET_KEY:
        raise ValueError("CRITICAL SECURITY ERROR: JWT_SECRET_KEY tidak ditemukan di file .env! Dilarang keras menggunakan hardcoded secret.")
        
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
    DEBUG = True
    TESTING = False


class ProductionConfig(Config):
    DEBUG = False
    TESTING = False
    SQLALCHEMY_ECHO = False


class TestingConfig(Config):
    DEBUG = True
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'  


config_dict = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}

def get_config(env=None):
    if env is None:
        env = os.getenv('FLASK_ENV', 'development')
    return config_dict.get(env, DevelopmentConfig)