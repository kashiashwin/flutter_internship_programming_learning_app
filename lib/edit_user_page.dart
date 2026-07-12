import 'package:flutter/material.dart';
import 'database_helper.dart';

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditUserPage({
    super.key,
    required this.user,
  });

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController fullnameController;
  late TextEditingController emController;
  late TextEditingController passController;


  @override
  void initState() {
    super.initState();

    fullnameController =
        TextEditingController(text: widget.user['username '].toString());

    emController =
        TextEditingController(text: widget.user['email'].toString());

    passController =
        TextEditingController(text: widget.user['password'].toString());

  }

  Future<void> updateUser() async {
    await DatabaseHelper().updateUser({
      'id': widget.user['id'],
      'username': fullnameController.text,
      'email': emController.text,
      'password': passController.text,
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: fullnameController,
              decoration:
              const InputDecoration(labelText: "Full Name"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: emController,
              decoration:
              const InputDecoration(labelText: "email"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: passController,
              decoration:
              const InputDecoration(labelText: "password"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: updateUser,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
      ),
    );
  }
}