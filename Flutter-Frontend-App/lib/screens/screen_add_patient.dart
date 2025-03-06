import 'package:flutter/material.dart';

class ScreenAddPatient extends StatefulWidget {
  const ScreenAddPatient({super.key});

  @override
  State<ScreenAddPatient> createState() => _ScreenAddPatientState();
}

class _ScreenAddPatientState extends State<ScreenAddPatient> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Basic Info Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // Additional Dental Details
  final TextEditingController _chiefComplaintController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _currentMedicationsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free resources when this screen is removed
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

  void _savePatient() {
    // Validate the required fields in the form
    if (_formKey.currentState!.validate()) {
      // For now, just print the data to console or handle your logic here
      debugPrint("Name: ${_nameController.text}");
      debugPrint("Age: ${_ageController.text}");
      debugPrint("Phone: ${_phoneController.text}");
      debugPrint("DOB: ${_dobController.text}");
      debugPrint("Chief Complaint: ${_chiefComplaintController.text}");
      debugPrint("Medical History: ${_medicalHistoryController.text}");
      debugPrint("Allergies: ${_allergiesController.text}");
      debugPrint("Current Medications: ${_currentMedicationsController.text}");
      debugPrint("Additional Notes: ${_notesController.text}");

      // After saving to your database or API, you can pop the screen or show a success message
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a back button
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: const Text(
          "Add Dental Patient",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFE0F7EF), // Light green background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // NAME
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name *",
                  hintText: "Enter patient's full name",
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the patient's name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // AGE
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age *",
                  hintText: "Enter patient's age",
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the patient's age";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // PHONE
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone *",
                  hintText: "Enter patient's phone number",
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the patient's phone number";
                  }
                  // You can add more robust validation (e.g., length, pattern)
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // DOB
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: "DOB *",
                  hintText: "Enter patient's date of birth (DD/MM/YYYY)",
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the patient's date of birth";
                  }
                  // You can add date format validation
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // CHIEF COMPLAINT
              TextFormField(
                controller: _chiefComplaintController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Chief Complaint",
                  hintText: "Describe the main dental issue or complaint",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),

              // MEDICAL HISTORY
              TextFormField(
                controller: _medicalHistoryController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Medical History",
                  hintText: "Relevant past medical or dental history",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),

              // ALLERGIES
              TextFormField(
                controller: _allergiesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Allergies",
                  hintText: "List any known allergies (medications, etc.)",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),

              // CURRENT MEDICATIONS
              TextFormField(
                controller: _currentMedicationsController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Current Medications",
                  hintText: "List any medications the patient is taking",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),

              // ADDITIONAL NOTES
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Additional Notes",
                  hintText: "Any other relevant details",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 24),

              // SAVE BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
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
}
