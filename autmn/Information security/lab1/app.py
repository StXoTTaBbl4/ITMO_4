from flask import Flask, request, jsonify
from models import db, User
from config import Config
from auth import hash_password, verify_password, create_jwt, decode_jwt
from markupsafe import escape
import os

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)

    with app.app_context():
        db.create_all()

    @app.route("/auth/login", methods=["POST"])
    def login():
        data = request.get_json() or {}
        username = data.get("username")
        password = data.get("password")
        if not username or not password:
            return jsonify({"error": "username and password required"}), 400

        user = User.query.filter_by(username=username).first()
        if not user or not verify_password(password, user.password_hash):
            return jsonify({"error": "invalid credentials"}), 401

        token = create_jwt({"sub": user.id, "username": user.username},
                           app.config["SECRET_KEY"],
                           app.config["JWT_ALGORITHM"],
                           app.config["JWT_EXP_DELTA"])
        return jsonify({"access_token": token})

    def require_auth(fn):
        from functools import wraps
        @wraps(fn)
        def wrapper(*args, **kwargs):
            auth_header = request.headers.get("Authorization", "")
            if not auth_header.startswith("Bearer "):
                return jsonify({"error": "authorization required"}), 401
            token = auth_header.split(" ", 1)[1].strip()
            try:
                payload = decode_jwt(token, app.config["SECRET_KEY"], [app.config["JWT_ALGORITHM"]])
                # print("JWT payload:", payload)
            except Exception as e:
                # print("JWT decode error:", e)
                return jsonify({"error": "invalid token", "details": str(e)}), 401
            return fn(payload, *args, **kwargs)
        return wrapper

    @app.route("/api/data", methods=["GET"])
    @require_auth
    def get_data(payload):
        users = User.query.all()
        result = []
        for u in users:
            result.append({
                "id": u.id,
                "username": escape(u.username),
                "created_at": u.created_at.isoformat()
            })
        return jsonify(result)

    @app.route("/auth/register", methods=["POST"])
    def register():
        data = request.get_json() or {}
        username = data.get("username")
        password = data.get("password")
        # print("DEBUG raw data:", request.data)
        # print("DEBUG json:", request.get_json())
        # print("DEBUG username:", username, "password:", password)
        if not username or not password:
            return jsonify({"error": "username and password required"}), 400
        if User.query.filter_by(username=username).first():
            return jsonify({"error": "username exists"}), 400
        user = User(username=username, password_hash=hash_password(password))
        db.session.add(user)
        db.session.commit()
        return jsonify({"message": "created"}), 201

    return app

if __name__ == "__main__":
    app = create_app()
    debug_mode = os.getenv("DEBUG_MODE", "false").lower() == "true"
    host = os.getenv("HOST", "127.0.0.1")
    app.run(debug=debug_mode, host=host, port=int(os.environ.get("PORT", 5000)))
