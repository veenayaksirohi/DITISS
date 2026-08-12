from flask import Flask

def create_app():
    app = Flask(__name__)

    @app.route('/', methods=['GET'])
    def root():
        return "welcome to flask app"

    @app.route('/version', methods=['GET'])
    def version():
        return "v1.0"

    @app.route('/health', methods=['GET'])
    def health():
        return "healthy"

    return app