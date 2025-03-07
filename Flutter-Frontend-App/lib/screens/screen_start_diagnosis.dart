import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/screen_patient_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenStartDiagnosis extends StatefulWidget {
  const ScreenStartDiagnosis({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenStartDiagnosisState createState() => _ScreenStartDiagnosisState();
}

class _ScreenStartDiagnosisState extends State<ScreenStartDiagnosis> {
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _problemController1 = TextEditingController();
  final TextEditingController _problemController2 = TextEditingController();

  Future<void> _uploadData() async {
    const String apiUrl = "https://yourapi.com/diagnosis"; // Replace with actual API URL

    Map<String, dynamic> requestData = {
      "symptoms": _symptomsController.text,
      "problem1": _problemController1.text,
      "problem2": _problemController2.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Parse response if needed
        final responseData = jsonDecode(response.body);
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => ScreenPatientDetails(
              name: responseData['name'] ?? 'Unknown',
              diagnosis: responseData['diagnosis'] ?? 'N/A',
              age: responseData['age'] ?? 0,
              phone: responseData['phone'] ?? 'N/A',
              dob: responseData['dob'] ?? 'N/A',
              chiefComplaint: responseData['chiefComplaint'] ?? 'N/A',
              medicalHistory: responseData['medicalHistory'] ?? 'N/A',
              provisionalDiagnosis: responseData['provisionalDiagnosis'] ?? 'N/A',
              treatmentPlan: responseData['treatmentPlan'] ?? 'N/A',
              oralHygieneAdvice: responseData['oralHygieneAdvice'] ?? 'N/A',
            ),
          ),
        );
      } else {
        _showError("Failed to upload data: ${response.body}");
      }
    } catch (e) {
      _showError("Error: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "START DIAGNOSING",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE0F7EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUploadCard(label: "X-Ray upload", onTap: () {}),
                _buildUploadCard(label: "Old medical record\nupload (PDF)", onTap: () {}),
              ],
            ),
            const SizedBox(height: 20),
            _buildLabeledTextField(label: "Enter the symptoms:", controller: _symptomsController),
            _buildLabeledTextField(label: "Brief your current problem:", controller: _problemController1),
            _buildLabeledTextField(label: "Brief your current problem:", controller: _problemController2),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: _uploadData,
              child: const Text("UPLOAD"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard({required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, size: 40, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildLabeledTextField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
            child: TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12)),
            ),
          ),
        ],
      ),
    );
  }
}
