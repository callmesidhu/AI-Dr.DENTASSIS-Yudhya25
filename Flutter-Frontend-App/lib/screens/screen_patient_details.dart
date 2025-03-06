import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/screen_start_diagnosis.dart';

class ScreenPatientDetails extends StatelessWidget {
  // Sample fields. Replace with actual data or make them dynamic as needed.
  final String name;
  final String diagnosis;
  final int age;
  final String phone;
  final String dob;
  final String chiefComplaint;
  final String medicalHistory;
  final String provisionalDiagnosis;
  final String treatmentPlan;
  final String oralHygieneAdvice;

  const ScreenPatientDetails({
    super.key,
    required this.name,
    required this.diagnosis,
    required this.age,
    required this.phone,
    required this.dob,
    required this.chiefComplaint,
    required this.medicalHistory,
    required this.provisionalDiagnosis,
    required this.treatmentPlan,
    required this.oralHygieneAdvice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light background color
      backgroundColor: const Color(0xFFE0F7EF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Title + "DELETE THIS PATIENT" button
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back
                    },
                  ),
                      const Text(
                    "PATIENT DETAILS",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    
                  ),SizedBox(height: 35, width: 1)],
                  ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(2, 0 , 0, 0),
                     child: Positioned(
                      top: 20, 
                      right: 8,
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      
                      children: [
                        SizedBox(
                          height: 10,
                          width: 1,
                        ),
                         ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        onPressed: () {
                       
                          print("DELETE THIS PATIENT pressed!");
                        },
                        child: const Text("DELETE THIS PATIENT"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 205, 64, 64),
                          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenStartDiagnosis(),
                            ),
                          );

                        },
                        child: const Text("DIAGNOSE THIS PATIENT"),
                      ),
                      ],
                     ),
                                      ),
                   )
                ],
              ),
              

              // Patient Information
              _buildSectionHeader("Patient Information"),
              _buildInfoContainer(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: $name"),
                    Text("Diagnosis: $diagnosis"),
                    Text("Age: $age"),
                    Text("Phone: $phone"),
                    Text("DOB: $dob"),
                  ],
                ),
              ),

              // Chief Complaint
              _buildSectionHeader("Chief Complaint"),
              _buildInfoContainer(
                Text(chiefComplaint),
              ),

              // Medical History
              _buildSectionHeader("Medical History"),
              _buildInfoContainer(
                Text(medicalHistory),
              ),

              // Provisional Diagnosis
              _buildSectionHeader("Provisional Diagnosis"),
              _buildInfoContainer(
                Text(provisionalDiagnosis),
              ),

              // Treatment Plan
              _buildSectionHeader("Treatment Plan"),
              _buildInfoContainer(
                Text(treatmentPlan),
              ),

              // Oral Hygiene Advice
              _buildSectionHeader("Oral Hygiene Advice"),
              _buildInfoContainer(
                Text(oralHygieneAdvice),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a section header, e.g. "Patient Information"
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  /// Builds a container with a white background and some padding
  Widget _buildInfoContainer(Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
