import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:inventory_management_system_2/constants/person_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Api"),
        backgroundColor: Colors.green,
        elevation: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.person),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user['email'];
          // final name = user['first_name'];
          // final avatar = user['avatar'];
          return ListTile(
            trailing: const Icon(Icons.email),
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                // child: Image.network(avatar),
              ),
            ),
            title: Text(email),
            // subtitle: Text(name),
          );
        },
      ),
    );
  }

  void fetchUsers() async {
    //print("fetchUsers called");
    const url = "https://reqres.in/api/users?page=2";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
    // print('fetchUsers completed');
  }
}
