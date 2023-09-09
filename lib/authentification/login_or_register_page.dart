// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'register_page.dart';

class change_page extends StatefulWidget {
  const change_page({super.key});

  @override
  State<change_page> createState() => _change_pageState();
}

class _change_pageState extends State<change_page> {
  bool showing_login_page = true;

  void toggle_pages() {
    setState(() {
      showing_login_page = !showing_login_page;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showing_login_page) {
      return SignUp(
        toggle_function: toggle_pages,
      );
    } else {
      return Register(
        toggle_function: toggle_pages,
      );
    }
  }
}
