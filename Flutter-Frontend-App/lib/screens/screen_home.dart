import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/screen_add_patient.dart';
import 'package:flutter_frontend/screens/screen_patient_details.dart';

class ScreenHome extends StatelessWidget {
  final String doctorName;

  const ScreenHome({
    super.key,
    required this.doctorName, // Pass the doctor’s name if you want to display it dynamically
  });

  @override
  Widget build(BuildContext context) {
    // Sample patient data; replace with real data from your backend or state management
    final List<Map<String, String>> patients = [
      {
        'name': 'Vaishnavi',
        'age': '20',
        'phone': '987654321',
        'dob': '20/02/2022',
      },
      {
        'name': 'Vaishnavi',
        'age': '20',
        'phone': '987654321',
        'dob': '20/02/2022',
      },
      {
        'name': 'Vaishnavi',
        'age': '20',
        'phone': '987654321',
        'dob': '20/02/2022',
      },
      // Add as many rows as you like
    ];

    return Scaffold(
      // Light green background (adjust as needed)
      backgroundColor: const Color(0xFFE0F7EF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Header
            Container(
              color: Colors.lightGreen,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "WELCOME DR. $doctorName",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // Circle avatar (placeholder)
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Column headings
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Age",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Phone",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "DOB",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Divider below headings
            const Divider(height: 1, thickness: 1),

            // Patient list
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () { Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenPatientDetails(
                                name: 'Vaishnavi',
                                diagnosis: 'Deep Dental Caries',
                                age: 20,
                                phone: '987654321',
                                dob: '20/02/2022',
                                chiefComplaint: 'The patient complains of tooth pain jiwoegjoiejgioejigeioejiojgeioj',
                                medicalHistory: 'No history of diabetes or hypertension...sji ewjiogjeiogj ieojgiejigjeo giej giejg ejgi ejogjeg eigj eogjeojge',
                                provisionalDiagnosis: 'Deep dental caries... j eoijg iejgieej iojww jwjeoijwj gwjewj gjij j ijojweij ie gjgjejoiwg ewio jg wejigojw oi gjwoijgoijw gjweoijwgoijgpi wejoi joiwjwegje wejwewjeewjew9uhjeiuewhiuhewiu iewh',
                                treatmentPlan: 'Root canal treatment, restoration... w igjeiu ghewi hgiuehiugwheiu h giu hwiuehewu9gh98u3w9heh g8eu30u30uu4u09w09iu0w njn s jifn wiosj ewjo owfj ewo wsiogj oejgweioj gg ig iwj wegoj wegj weojeoigwj  gjwoiwj geogeij ',
                                oralHygieneAdvice: 'Brush twice daily, floss regularly... joioge joiwje iojeogjjegoje iogejigjioegjiojegioejgo jewoejijiojeiojgioejojoewijgi ojwoijoegwjiogjow jowj jweoj ogwjo',
                              ),
                            ),
                          );
                          },
                                                  child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(patient['name'] ?? ''),
                              Text(patient['age'] ?? ''),
                              Text(patient['phone'] ?? ''),
                              Text(patient['dob'] ?? ''),
                            ],
                          ),
                        ),
                      ),
                      // Divider after each row
                      const Divider(height: 1, thickness: 1),
                    ],
                  );
                },
              ),
            ),

            // Bottom "ADD PATIENT" button
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