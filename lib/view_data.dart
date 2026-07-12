import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'sign_up.dart';
import 'edit_user_page.dart';
import 'Login.dart';

class UserListPageNew extends StatefulWidget {
  const UserListPageNew({super.key});

  @override
  State<UserListPageNew> createState() => _UserListPageNewState();
}

class _UserListPageNewState extends State<UserListPageNew> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await DatabaseHelper().getUsers();

    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      body: users.isEmpty
          ? const Center(
        child: Text("No Data Found"),
      )
          :
      ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child:
            ListTile(
              title: Text(users[index]['username'].toString()),
              subtitle: Text(
                "${users[index]['email'].toString()} | ${users[index]['password'].toString()}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(users[index]['gender'].toString()),

                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditUserPage(
                            user: users[index],
                          ),
                        ),
                      );

                      if (result == true) {
                        loadUsers();
                      }

                      print("Edit id = ${users[index]['id']}");
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: ()async {
                      await DatabaseHelper()
                          .deleteUser(users[index]['id']);

                      bool? confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Delete"),
                          content: const Text(
                            "Are you sure you want to delete this user?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false),
                              child: const Text("No"),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, true),
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await DatabaseHelper()
                            .deleteUser(users[index]['id']);

                        loadUsers();
                      }

                      print("Delete id = ${users[index]['id']}");
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}