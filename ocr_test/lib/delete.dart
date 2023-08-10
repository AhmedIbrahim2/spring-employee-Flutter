import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'home.dart';

class DeleteUserScreen extends StatefulWidget {
  final int userId;

  DeleteUserScreen({required this.userId});

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  Future<void> deleteUser() async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:8080/deleteuser/${widget.userId}'),
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserListScreen(),
            ));
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete this user?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: deleteUser,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
