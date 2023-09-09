import 'package:conspirapcy/animation/FadeLoop.dart';
import 'package:conspirapcy/animation/Fade_Animation.dart';
import 'package:conspirapcy/authentification/auth_page2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class connexion extends StatefulWidget {
  const connexion({super.key});

  @override
  State<connexion> createState() => _connexionState();
}

class _connexionState extends State<connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 16, 15, 15),
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
            horizontal: 60,
          ),
          child: Column(
            children: [
              fadeIn_fadeOut(
                  delay: 3,
                  image: SizedBox(
                    height: 300,
                    child: Image.asset('images/logo.jpeg'),

                    /// A modifier
                  )),
              const SizedBox(
                height: 40,
              ),
              fadeIn_fadeOut(
                delay: 4,
                image: Text(
                  "Crée ton compte et viens découvrir des moments de légendes ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              fadeIn_fadeOut(
                delay: 5,
                image: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Auth_page2(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.all(13),
                    ),
                    child: Text(
                      "Connecte-toi ici frérot",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const FadeTransitionExample(),
            ],
          ),
        ),
      ),
    );
  }
}
