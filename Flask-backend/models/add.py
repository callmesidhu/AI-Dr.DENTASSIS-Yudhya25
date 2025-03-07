from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Patient(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    phone = db.Column(db.String(15), nullable=False)
    dob = db.Column(db.String(20), nullable=False)
    chief_complaint = db.Column(db.Text, nullable=True)
    medical_history = db.Column(db.Text, nullable=True)
    allergies = db.Column(db.Text, nullable=True)
    current_medications = db.Column(db.Text, nullable=True)
    notes = db.Column(db.Text, nullable=True)

    def __init__(self, name, age, phone, dob, chief_complaint=None, medical_history=None, allergies=None, current_medications=None, notes=None):
        self.name = name
        self.age = age
        self.phone = phone
        self.dob = dob
        self.chief_complaint = chief_complaint
        self.medical_history = medical_history
        self.allergies = allergies
        self.current_medications = current_medications
        self.notes = notes