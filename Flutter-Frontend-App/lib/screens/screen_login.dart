import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/screen_home.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7EF), // Light green background
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // "HEY, DOCTOR"
              Column(
                children: [
                  Text(
              "HEY, DOCTOR",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
                            ),
                            const SizedBox(height: 8),
                      
              
                            // "WELCOME TO DR.DENTASSIS"
                            Text(
              "WELCOME TO DR.DENTASSIS",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
                            ),
                            const SizedBox(height: 30),
                      
                ],
              ),
              // Logo image
              Image.asset(
                'assets/images/home.png',  // Make sure this path matches your asset
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 30),
        
              // Elevated Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 42, 42, 42), // Button color
                  foregroundColor: Colors.white, // Text color
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScreenHome(doctorName: 'Harsha',)),
            );
                },
                child: const Text("G   Login with google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
