# import the create_app function
from app import create_app

# import pytest to use the fixture decorator
import pytest

@pytest.fixture()
def app():
    # create the app
    app = create_app()

    # set the flag that this is a test application
    # and not the real server
    app.config['TESTING'] = True

    # yield the application instance
    yield app


@pytest.fixture()
def client(app):
    return app.test_client()

def test_root(client):
    # send a dummy request to /
    response = client.get("/")

    # check if the response status code is 200
    assert(response.status_code == 200)

def test_health(client):
    # send a dummy request to /health
    response = client.get('/health')

    # check if response status code is 200
    assert(response.status_code == 200)