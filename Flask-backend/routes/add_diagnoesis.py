import os
from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
from models import db, Patient

app = Flask(__name__)

# Configure file upload folder
UPLOAD_FOLDER = 'uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Allowed extensions
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'pdf'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/add_patient', methods=['POST'])
def add_patient():
    if 'xray' not in request.files or 'prescription' not in request.files:
        return jsonify({'error': 'X-ray and prescription files are required'}), 400
    
    xray = request.files['xray']
    prescription = request.files['prescription']
    
    problem = request.form.get('problem')
    allergies = request.form.get('allergies')
    pains = request.form.get('pains')

    if not problem:
        return jsonify({'error': 'Problem field is required'}), 400
    
    if xray and allowed_file(xray.filename):
        xray_filename = secure_filename(xray.filename)
        xray.save(os.path.join(app.config['UPLOAD_FOLDER'], xray_filename))
    else:
        return jsonify({'error': 'Invalid X-ray file format'}), 400

    if prescription and allowed_file(prescription.filename):
        prescription_filename = secure_filename(prescription.filename)
        prescription.save(os.path.join(app.config['UPLOAD_FOLDER'], prescription_filename))
    else:
        return jsonify({'error': 'Invalid prescription file format'}), 400

    # Save patient details in database
    new_patient = Patient(
        problem=problem,
        allergies=allergies,
        pains=pains,
        xray_filename=xray_filename,
        prescription_filename=prescription_filename
    )
    db.session.add(new_patient)
    db.session.commit()

    return jsonify({'message': 'Patient added successfully'}), 201
