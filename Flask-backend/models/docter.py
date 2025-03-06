# models.py
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    google_id = db.Column(db.String(256), unique=True, nullable=False)
    name = db.Column(db.String(256))
    email = db.Column(db.String(256), unique=True, nullable=False)

    def __repr__(self):
        return f'<User {self.email}>'