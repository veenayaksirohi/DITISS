from app import create_app

# create the application instance
app = create_app()

# run the flask application
app.run(host="0.0.0.0", port=4000, debug=True)