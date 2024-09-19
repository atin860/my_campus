import 'package:flutter/material.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Center the whole column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login or Sign Up',
              style: TextStyle(
                fontSize: 35,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // Add some space between text and form
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text, // Change to appropriate type
                    decoration: InputDecoration(
                      labelText: 'Username or User ID', // Label for the text field
                      border: OutlineInputBorder(), // Optional: border for the text field
                      filled: true,
                      fillColor: Colors.white, // Background color for the text field
                    ),
                  ),
                  SizedBox(height: 20), // Space between fields
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true, // Hide password input
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20), // Space before button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login action
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
