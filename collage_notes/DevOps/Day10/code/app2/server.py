from app import create_app

# create the application instance
app = create_app()

# start the flask server
app.run(host='0.0.0.0', port=5500)
