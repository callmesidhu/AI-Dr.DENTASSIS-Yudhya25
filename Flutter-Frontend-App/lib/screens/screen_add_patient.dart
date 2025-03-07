import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenAddPatient extends StatefulWidget {
  const ScreenAddPatient({super.key});

  @override
  State<ScreenAddPatient> createState() => _ScreenAddPatientState();
}

class _ScreenAddPatientState extends State<ScreenAddPatient> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _chiefComplaintController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _currentMedicationsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _chiefComplaintController.dispose();
    _medicalHistoryController.dispose();
    _allergiesController.dispose();
    _currentMedicationsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _savePatient() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('https://localhost:5000/patients'); // Change to your API endpoint

      final Map<String, dynamic> patientData = {
        "name": _nameController.text,
        "age": _ageController.text,
        "phone": _phoneController.text,
        "dob": _dobController.text,
        "chief_complaint": _chiefComplaintController.text,
        "medical_history": _medicalHistoryController.text,
        "allergies": _allergiesController.text,
        "current_medications": _currentMedicationsController.text,
        "notes": _notesController.text,
      };

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(patientData),
        );

        if (response.statusCode == 201) {
          // Success: Show a success message and go back
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Patient added successfully!')),
          );
          Navigator.pop(context);
        } else {
          // Error: Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add patient: ${response.body}')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: const Text("Add Dental Patient", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFE0F7EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_nameController, "Name *", "Enter patient's full name"),
              _buildTextField(_ageController, "Age *", "Enter patient's age", keyboardType: TextInputType.number),
              _buildTextField(_phoneController, "Phone *", "Enter patient's phone number", keyboardType: TextInputType.phone),
              _buildTextField(_dobController, "DOB *", "Enter patient's date of birth (DD/MM/YYYY)"),
              _buildTextField(_chiefComplaintController, "Chief Complaint", "Describe the main dental issue", maxLines: 3),
              _buildTextField(_medicalHistoryController, "Medical History", "Relevant past medical history", maxLines: 3),
              _buildTextField(_allergiesController, "Allergies", "List any known allergies", maxLines: 2),
              _buildTextField(_currentMedicationsController, "Current Medications", "List any medications", maxLines: 2),
              _buildTextField(_notesController, "Additional Notes", "Any other relevant details", maxLines: 4),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: _savePatient,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          fillColor: Colors.white,
          filled: true,
        ),
        validator: (value) {
          if (label.contains('*') && (value == null || value.trim().isEmpty)) {
            return "Please enter the $label";
          }
          return null;
        },
      ),
    );
  }
}
