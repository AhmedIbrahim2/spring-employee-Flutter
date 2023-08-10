import 'package:flutter/material.dart';
import "dart:convert";

import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  final BuildContext context; // Add a context parameter

  RegisterPage({required this.context});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    final String apiUrl =
        'http://localhost:8080/register'; // Replace with your actual API URL

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      'email': _usernameController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // Login successful
        // Navigate to home page or perform any other actions
        print('Login successful');
        Navigator.pushNamed(context, '/userList');
      } else {
        // Login failed
        print('Login failed');
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform registration operation
                _register();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
