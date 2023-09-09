// ignore_for_file: non_constant_identifier_names

import 'package:conspirapcy/authentification/register_page_2.dart';
import 'package:conspirapcy/elements/Button.dart';
import 'package:conspirapcy/elements/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Register extends StatefulWidget {
  final Function()? toggle_function;
  const Register({super.key, required this.toggle_function});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailTextController = TextEditingController();
  final pseudoTextController = TextEditingController();
  final nomCompteTextController = TextEditingController();

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
          child: Center(
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Veuillez entrer les informations demandées",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obsureText: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: pseudoTextController,
                  hintText: 'Pseudo',
                  obsureText: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: nomCompteTextController,
                  hintText: 'Nom du compte',
                  obsureText: false,
                ),
                const SizedBox(
                  height: 130,
                ),
                MyButton(
                  onTap: () {
                    bool test = emailTextController.text.isEmpty ||
                        pseudoTextController.text.isEmpty ||
                        nomCompteTextController.text.isEmpty;
                    if (!test) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register2(
                            nomCompteText: nomCompteTextController.text,
                            pseudoText: pseudoTextController.text,
                            emailText: emailTextController.text,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Complétez les champs ci-dessus"),
                        ),
                      );
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                  text: 'Suivant',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "T'as déjà un compte frérot ? ",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
