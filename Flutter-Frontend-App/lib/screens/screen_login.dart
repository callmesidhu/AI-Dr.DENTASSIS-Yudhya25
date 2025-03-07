import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_frontend/screens/screen_home.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool isLoading = false;

  Future<void> loginWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    const String apiUrl = 'https://localhost:5000/login'; // Replace with your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String doctorName = data['doctorName'] ?? 'Doctor';

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenHome(doctorName: doctorName),
          ),
        );
      } else {
        showError("Login failed. Please try again.");
      }
    } catch (e) {
      showError("Something went wrong. Please try again.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7EF),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "HEY, DOCTOR",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "WELCOME TO DR.DENTASSIS",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              Image.asset('assets/images/home.png', width: 120, height: 120),
              const SizedBox(height: 30),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
                        foregroundColor: Colors.white,
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
                      onPressed: loginWithGoogle,
                      child: const Text("G   Login with Google"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
