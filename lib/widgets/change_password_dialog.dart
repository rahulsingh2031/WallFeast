import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({
    super.key,
    required this.passwordController,
    required this.mounted,
    required this.context,
  });

  final TextEditingController passwordController;
  final bool mounted;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Row(
        children: [
          Icon(Icons.warning),
          Text("Change Password"),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "New Password",
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;

                await user?.updatePassword(passwordController.text);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Successfully password changed")));
                }
                Navigator.pop(context);
              },
              child: const Text("Confirm")),
        )
      ],
    );
  }
}
