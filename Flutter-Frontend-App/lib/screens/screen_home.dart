import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_frontend/screens/screen_add_patient.dart';
import 'package:flutter_frontend/screens/screen_patient_details.dart';

class ScreenHome extends StatefulWidget {
  final String doctorName;

  const ScreenHome({super.key, required this.doctorName});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<dynamic> patients = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    const String apiUrl = 'https://your-api-url.com/patients'; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          patients = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7EF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              color: Colors.lightGreen,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "WELCOME DR. ${widget.doctorName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Column Headings
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Phone", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("DOB", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1),

            // Patient List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : hasError
                      ? const Center(child: Text("Failed to load data."))
                      : ListView.builder(
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            final patient = patients[index];

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScreenPatientDetails(
                                          name: patient['name'] ?? '',
                                          age: int.tryParse(patient['age'].toString()) ?? 0,
                                          phone: patient['phone'] ?? '',
                                          dob: patient['dob'] ?? '',
                                          diagnosis: patient['diagnosis'] ?? 'N/A',
                                          chiefComplaint: patient['chief_complaint'] ?? 'N/A',
                                          medicalHistory: patient['medical_history'] ?? 'N/A',
                                          provisionalDiagnosis: patient['provisional_diagnosis'] ?? 'N/A',
                                          treatmentPlan: patient['treatment_plan'] ?? 'N/A',
                                          oralHygieneAdvice: patient['oral_hygiene_advice'] ?? 'N/A',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(patient['name'] ?? ''),
                                        Text(patient['age'].toString()),
                                        Text(patient['phone'] ?? ''),
                                        Text(patient['dob'] ?? ''),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(height: 1, thickness: 1),
                              ],
                            );
                          },
                        ),
            ),

            // "Add Patient" Button
            Container(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScreenAddPatient()),
                  );
                },
                child: const Text("ADD PATIENT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
