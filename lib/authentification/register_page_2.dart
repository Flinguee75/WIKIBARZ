// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conspirapcy/elements/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../elements/text_field.dart';

class Register2 extends StatefulWidget {
  final String emailText;
  final String pseudoText;
  final String nomCompteText;

  const Register2(
      {super.key,
      required this.nomCompteText,
      required this.pseudoText,
      required this.emailText});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final confirmpasswordTextController = TextEditingController();

  final passwordTextController = TextEditingController();
  final String defaultpath =
      'https://th.bing.com/th/id/OIP.EILQYpqwarBg2w9zy4Ar9gHaFb?w=288&h=212&c=7&r=0&o=5&dpr=1.1&pid=1.7';

  void createaccount() async {
    try {
      if (passwordTextController.text == confirmpasswordTextController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: widget.emailText,
          password: passwordTextController.text,
        );
        FirebaseFirestore.instance
            .collection('USER')
            .doc(userCredential.user!.email)
            .set({
          'pseudo': widget.pseudoText,
          'date_creation': Timestamp.now(),
          'nom_compte': widget.nomCompteText,
          'image': defaultpath,
          "bio": "",
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Le mot de passe est faible"),
          ),
        );
        FocusScope.of(context).requestFocus(FocusNode());
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("L'email est déjà utilisé"),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "INSCRIPTION",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
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
            vertical: 20,
            horizontal: 30,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                textAlign: TextAlign.center,
                "Veuillez choisir et confirmez votre mot de passse",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MyTextField(
                controller: passwordTextController,
                hintText: 'Mot de passe',
                obsureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: confirmpasswordTextController,
                hintText: 'Confirmez le mot de passe ',
                obsureText: true,
              ),
              const SizedBox(
                height: 70,
              ),
              MyButton(
                onTap: () {
                  createaccount();
                },
                text: "CONFIRMER",
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 100,
                child: Image.asset(
                  'images/WIKIGRAFFITY.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
