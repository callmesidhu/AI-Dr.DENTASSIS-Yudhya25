from flask import Flask, session, redirect, url_for, render_template
from configs.config import Config
from flask_dance.contrib.google import make_google_blueprint, google
from flask_dance.consumer import oauth_authorized
from routes.auth import auth_bp
from models.user import db

app = Flask(__name__)
app.config.from_object(Config)

# Initialize SQLAlchemy with the app
db.init_app(app)

# Create database tables if they don't exist
with app.app_context():
    db.create_all()

# Set up the Google OAuth blueprint using Flask-Dance
google_bp = make_google_blueprint(
    client_id=app.config["GOOGLE_OAUTH_CLIENT_ID"],
    client_secret=app.config["GOOGLE_OAUTH_CLIENT_SECRET"],
    scope=[
        "openid", 
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/userinfo.profile"
    ]
)
app.register_blueprint(google_bp, url_prefix="/login")

# Register the custom auth blueprint
app.register_blueprint(auth_bp)

@app.route("/")
def index():
    if "user" in session:
        return f"Hello, {session['user']['email']}! <a href='/logout'>Logout</a>"
    return 'Welcome! Please <a href="/login/google">login with Google</a>.'

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))

@oauth_authorized.connect_via(google_bp)
def google_logged_in(blueprint, token):
    if not token:
        print("OAuth token is missing!")  # Debugging
        return redirect(url_for("index"))

    # Fetch user info to check token validity
    resp = google.get("/oauth2/v2/userinfo")
    if resp.ok:
        user_info = resp.json()
        print("User Info:", user_info)  # Debugging
        session["user"] = user_info  # Store user info in session
    else:
        print("Failed to fetch user info:", resp.text)

    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run(debug=True)
