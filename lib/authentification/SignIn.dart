// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:conspirapcy/animation/FadeLoop.dart';
import 'package:conspirapcy/elements/Button.dart';
import 'package:conspirapcy/elements/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class SignUp extends StatefulWidget {
  final Function()? toggle_function;
  const SignUp({super.key, this.toggle_function});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void SignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pas de compte trouvé par cet email."),
          ),
        );
        FocusScope.of(context).requestFocus(FocusNode());
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mauvais mot de passe."),
          ),
        );
        FocusScope.of(context).requestFocus(FocusNode());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 51, 88),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: const Color(0xFFEDECF2),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  "CONNEXION",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 65,
                ),
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obsureText: false,
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obsureText: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                  onTap: () {
                    SignIn();
                  },
                  text: 'CONNEXION',
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "T'as pas encore de compte frérot ? ",
                      style: GoogleFonts.poppins(
                        color: Colors.white54,
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.toggle_function,
                      child: Text(
                        " Clique Ici",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  height: 80,
                  child: FadeTransitionExample(
                    color: const Color.fromARGB(255, 30, 51, 88),
                    image: Image.asset("images/WIKIGRAFFITY.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
