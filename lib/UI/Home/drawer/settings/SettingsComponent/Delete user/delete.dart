import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../userProfile/widgets/appbar_widget.dart';

class UserList extends StatefulWidget {
  static const routeName = 'UserList';

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String errorMessage = '';
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      setState(() {
        errorMessage = 'Token is not available';
      });
      return;
    }
    final response = await http.post(
      Uri.parse('https://4cda-154-178-203-69.ngrok-free.app/api/users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['users'];
      });
    } else {
      setState(() {
        errorMessage = 'Failed to load users';
      });
      throw Exception('Failed to load users');
    }
  }

  Future<void> deleteUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      setState(() {
        errorMessage = 'Token is not available';
      });
      return;
    }
    final response = await http.delete(
      Uri.parse('https://4cda-154-178-203-69.ngrok-free.app/api/delete/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'id': userId}),
    );
    if (response.statusCode == 200) {
      setState(() {
        users.removeWhere((user) => user['id'] == userId);
      });
    } else {
      setState(() {
        errorMessage = 'Failed to delete user';
      });
      throw Exception('Failed to delete user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(appName: 'Delete User'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
          child: Column(
            children: [
              errorMessage.isNotEmpty
                  ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 20)))
                  : users.isEmpty
                  ? Center(child: Icon(Icons.warning, size: 300, color: Colors.grey))
                  : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 6,
                          child: ListTile(
                            title: Text('User ${user['name']}', style: TextStyle(color: Colors.teal, fontSize: 20)),
                            subtitle: Text('Email: ${user['email']}'),
                            trailing: IconButton(
                              onPressed: () {
                                deleteUser(user['id']);
                              },
                              icon: Icon(Icons.close),
                            ),
                            iconColor: Colors.red,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
