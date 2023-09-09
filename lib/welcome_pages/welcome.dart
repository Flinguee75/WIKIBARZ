import 'package:conspirapcy/welcome_pages/welcome_2.dart';
import '../animation/Delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 16, 15, 15),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 60,
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Delayed_animation(
              delay: 1000,
              child: Image.asset(
                'images/titre.png',
                height: 50,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Delayed_animation(
              delay: 1500,
              child: Image.asset(
                'images/alpha.jpeg',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Delayed_animation(
              delay: 2000,
              child: Text(
                "Decouvrez les meilleurs freestyles ici, \n (Image à modifier)",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Delayed_animation(
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const connexion(),
                      ),
                    );
                  },
                  child: Text(
                    'Viens Découvrir des Barz',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(13),
                  ),
                ),
              ),
              delay: 2500,
            ),
          ],
        ),
      ),
    );
  }
}
