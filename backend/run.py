"""
Application Entry Point
Run the Flask development server
"""
import os
from app import create_app

if __name__ == '__main__':
    # Get config from environment or use default (development)
    config_name = os.getenv('FLASK_ENV', 'development')
    
    # Create Flask app
    app = create_app(config_name)
    
    # Get API configuration
    api_host = os.getenv('API_HOST', '127.0.0.1')
    api_port = int(os.getenv('API_PORT', 5000))
    debug = os.getenv('FLASK_DEBUG', True) == 'True'
    
    # Run the server
    print(f'\n🚀 Starting Flask server in {config_name} mode...')
    print(f'   URL: http://{api_host}:{api_port}')
    print(f'   API Health: http://{api_host}:{api_port}/api/health\n')
    
    app.run(
        host=api_host,
        port=api_port,
        debug=debug,
        use_reloader=True
    )