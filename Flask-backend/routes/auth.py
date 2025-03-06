# routes.py
from flask import Blueprint, redirect, url_for, session, flash
from flask_dance.contrib.google import google
from models.user import db, User

auth_bp = Blueprint("auth", __name__)

@auth_bp.route("/login/google")
def google_login():
    if not google.authorized:
        # Redirect user to Google's login page
        return redirect(url_for("google.login"))
    
    # Fetch user info from Google
    resp = google.get("/oauth2/v2/userinfo")
    if resp.ok:
        user_info = resp.json()
        google_id = user_info["id"]
        email = user_info.get("email")
        name = user_info.get("name")

        # Check if user exists; if not, create a new user
        user = User.query.filter_by(google_id=google_id).first()
        if not user:
            user = User(google_id=google_id, email=email, name=name)
            db.session.add(user)
            db.session.commit()

        # Save minimal user info in session
        session["user"] = {"id": user.id, "email": user.email, "name": user.name}
        return redirect(url_for("index"))
    else:
        flash("Failed to fetch user info from Google.")
        return redirect(url_for("index"))


auth_bp = Blueprint("auth", __name__)

@auth_bp.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))