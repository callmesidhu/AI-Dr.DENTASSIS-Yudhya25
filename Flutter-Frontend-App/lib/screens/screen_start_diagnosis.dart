import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/screen_patient_details.dart';

class ScreenStartDiagnosis extends StatefulWidget {
  const ScreenStartDiagnosis({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenStartDiagnosisState createState() => _ScreenStartDiagnosisState();
}

class _ScreenStartDiagnosisState extends State<ScreenStartDiagnosis> {
  // Controllers for text fields (if you need to retrieve user input later)
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _problemController1 = TextEditingController();
  final TextEditingController _problemController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with functional back button
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Go back to previous screen
        ),
        title: const Text(
          "START DIAGNOSING",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // Light green background
      backgroundColor: const Color(0xFFE0F7EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for the two upload placeholders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUploadCard(
                  label: "X-Ray upload",
                  onTap: () {
                    // TODO: Implement X-Ray upload logic
                    debugPrint("X-Ray upload clicked");
                  },
                ),
                _buildUploadCard(
                  label: "Old medical record\nupload (PDF)",
                  onTap: () {
                    // TODO: Implement PDF upload logic
                    debugPrint("PDF upload clicked");
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Text fields
            _buildLabeledTextField(
              label: "Enter the symptoms:",
              controller: _symptomsController,
            ),
            _buildLabeledTextField(
              label: "Brief your current problem:",
              controller: _problemController1,
            ),
            _buildLabeledTextField(
              label: "Brief your current problem:",
              controller: _problemController2,
            ),
            const SizedBox(height: 20),

            // "UPLOAD" button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              onPressed: () {
  
                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenPatientDetails(
                                name: 'John Doe',
                                diagnosis: 'Diagnosis',
                                age: 30,
                                phone: '1234567890',
                                dob: '01-01-1990',
                                chiefComplaint: 'Chief Complaint',
                                medicalHistory: 'Medical History',
                                provisionalDiagnosis: 'Provisional Diagnosis',
                                treatmentPlan: 'Treatment Plan',
                                oralHygieneAdvice: 'Oral Hygiene Advice',
                              ),
                            ),
                          );
              },
              child: const Text("UPLOAD"),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds each upload card with a gray box and a plus icon.
  Widget _buildUploadCard({
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4, // Adjust as needed
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  /// Builds a labeled text field with a gray background.
  Widget _buildLabeledTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              maxLines: 3, // Adjust if you want a single-line or bigger area
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
