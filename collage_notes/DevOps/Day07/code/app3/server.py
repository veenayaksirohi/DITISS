from flask import Flask

# create flask app
app = Flask(__name__)

# create a route
@app.route("/", methods=['GET'])
def root():
    return "welcome to my flask application"

# run the application
app.run(port=5500, host="0.0.0.0", debug=True)