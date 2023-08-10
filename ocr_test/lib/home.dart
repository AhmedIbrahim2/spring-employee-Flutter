import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'create.dart';
import 'edit.dart';
import 'login.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void _logout() {
    // Perform any necessary logout operations
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(
                context: context,
              )), // Navigate back to the login page
    );
  }

  Future<void> fetchUsers() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/getusers'));
      if (response.statusCode == 200) {
        setState(() {
          _users = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool?> _navigateToCreateUserScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CreateUserScreen()),
    );
    if (result == true) {
      fetchUsers();
    }
  }

  Future<bool?> _navigateToEditUserScreen(dynamic user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditUserScreen(user: user)),
    );
    if (result == true) {
      fetchUsers();
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(int userId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await deleteUser(userId);
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      final response = await http
          .delete(Uri.parse('http://localhost:8080/deleteuser/$userId'));
      if (response.statusCode == 200) {
        fetchUsers();
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
        title: Text('User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToCreateUserScreen,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed:
                _logout, // Call the logout function when the button is pressed
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = _users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text('Salary: ${user['salary']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(user['title']),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateToEditUserScreen(user),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmationDialog(user['id']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
