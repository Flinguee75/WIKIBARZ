import 'package:conspirapcy/authentification/login_or_register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_interface/feed.dart';

class Auth_page2 extends StatelessWidget {
  const Auth_page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 16, 15, 15),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const user_page();
          } else {
            return const change_page();
          }
        },
      ),
    );
  }
}
