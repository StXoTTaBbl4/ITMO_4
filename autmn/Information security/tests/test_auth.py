# import pytest
#
# from app import create_app
# from models import db, User
# from auth import hash_password
#
# @pytest.fixture
# def client(tmp_path, monkeypatch):
#     app = create_app()
#     app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
#     app.config['TESTING'] = True
#     with app.test_client() as client:
#         with app.app_context():
#             db.create_all()
#             u = User(username="user1", password_hash=hash_password("secret"))
#             db.session.add(u)
#             db.session.commit()
#         yield client
#
# def test_login_success(client):
#     res = client.post("/auth/login", json={"username":"user1","password":"secret"})
#     assert res.status_code == 200
#     assert "access_token" in res.get_json()
#
# def test_get_data_unauth(client):
#     res = client.get("/api/data")
#     assert res.status_code == 401
