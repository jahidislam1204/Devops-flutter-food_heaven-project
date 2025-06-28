import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';
import 'screens/onboarding/onboarding_scrreen.dart';

void main() {
  runApp(const MyApp());
}

// The registerUser function to call your backend API
Future<void> registerUser(String fullName, String email, String phone, String password) async {
  final url = Uri.parse('http://<your-ec2-ip>:5000/api/register'); // <-- Replace with your backend IP/domain

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    print('Registration successful!');
  } else {
    print('Failed to register user: ${response.body}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodHaven - Food Delivery App [Md. Masum Billah]',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: bodyTextColor),
          bodySmall: TextStyle(color: bodyTextColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(defaultPadding),
          hintStyle: TextStyle(color: bodyTextColor),
        ),
      ),
      // Here, instead of OnboardingScreen, we inject a test screen with a button:
      home: const TestRegisterScreen(),
      // Replace TestRegisterScreen() with your OnboardingScreen() when ready
    );
  }
}

// A simple test screen with a button to call registerUser
class TestRegisterScreen extends StatelessWidget {
  const TestRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            registerUser(
              'Jahid Islam',
              'jahid@example.com',
              '01712345678',
              'yourpassword',
            );
          },
          child: const Text('Register User'),
        ),
      ),
    );
  }
}
