import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditUserScreen extends StatefulWidget {
  final dynamic user;

  EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user['name'];
    _salaryController.text = widget.user['salary'].toString();
    _titleController.text = widget.user['title'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    final updatedUser = {
      'name': _nameController.text,
      'salary': double.parse(_salaryController.text),
      'title': _titleController.text,
    };

    try {
      final response = await http.put(
        Uri.parse('http://localhost:8080/edituser/${widget.user['id']}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedUser),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
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
              onPressed: updateUser,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
