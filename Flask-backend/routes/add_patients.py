from flask import Blueprint, request, jsonify
from models import db, Patient

routes = Blueprint('routes', __name__)

@routes.route('/add_patient', methods=['POST'])
def add_patient():
    data = request.get_json()
    
    if not data:
        return jsonify({"error": "Invalid input"}), 400
    
    try:
        new_patient = Patient(
            name=data.get('name'),
            age=data.get('age'),
            phone=data.get('phone'),
            dob=data.get('dob'),
            chief_complaint=data.get('chief_complaint'),
            medical_history=data.get('medical_history'),
            allergies=data.get('allergies'),
            current_medications=data.get('current_medications'),
            notes=data.get('notes')
        )
        
        db.session.add(new_patient)
        db.session.commit()
        
        return jsonify({"message": "Patient added successfully!"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500
