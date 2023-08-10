import "dart:convert";

import "dart:js";

import "package:flutter/material.dart";
import "package:ocr_test/home.dart";
import "package:ocr_test/register.dart";
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final BuildContext context; // Add a context parameter

  LoginPage({required this.context});

  Future<void> _login() async {
    final String apiUrl =
        'http://localhost:8080/login'; // Replace with your actual API URL

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
        title: Text('Login Page'),
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
                // Perform login operation
                _login();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage(
                            context: context,
                          )),
                );
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
