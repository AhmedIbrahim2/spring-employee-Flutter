import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> createUser() async {
    final newUser = {
      'name': _nameController.text,
      'salary': double.parse(_salaryController.text),
      'title': _titleController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/createuser'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newUser),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: 'Salary',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createUser,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
