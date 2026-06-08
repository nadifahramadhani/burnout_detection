# app/routes/__init__.py
from app.routes import (
    auth_routes, lifestyle_routes, journal_routes,
    detection_routes, history_routes, profile_routes
)
__all__ = [
    'auth_routes', 'lifestyle_routes', 'journal_routes',
    'detection_routes', 'history_routes', 'profile_routes'
]
