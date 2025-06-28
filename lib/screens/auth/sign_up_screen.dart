import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> registerUser(String fullName, String email, String password) async {
    final url = Uri.parse('http://<your-ec2-ip>:5000/api/register'); // Replace with actual backend IP

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: ${response.body}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name
          TextFormField(
            controller: fullNameController,
            validator: RequiredValidator(errorText: "Full name is required"),
            decoration: const InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Email
          TextFormField(
            controller: emailController,
            validator: MultiValidator([
              RequiredValidator(errorText: "Email is required"),
              EmailValidator(errorText: "Enter a valid email"),
            ]),
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Password
          TextFormField(
            controller: passwordController,
            validator: MinLengthValidator(6, errorText: "Password must be at least 6 characters"),
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                registerUser(
                  fullNameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              }
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}
