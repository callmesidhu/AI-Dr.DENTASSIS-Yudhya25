from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Patient(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    problem = db.Column(db.String(255), nullable=False)
    allergies = db.Column(db.String(255), nullable=True)
    pains = db.Column(db.String(255), nullable=True)
    xray_filename = db.Column(db.String(255), nullable=True)
    prescription_filename = db.Column(db.String(255), nullable=True)
