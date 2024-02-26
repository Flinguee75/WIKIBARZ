import 'package:conspirapcy/animation/Fade_Animation.dart';
import 'package:conspirapcy/authentification/login_or_register_page.dart';
import 'package:conspirapcy/elements/CircleBox.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/grunt3.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width ?? 0,
                height: _controller.value.size.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 70,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: fadeIn_fadeOut(
                    image: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'images/titre.png',
                        width: 300,
                      ),
                    ),
                    delay: 2,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.topLeft,
                  child: fadeIn_fadeOut(
                      image: CircleBox(
                        height: 300,
                        width: 200,
                        widget: Image.asset('images/logo1.png'),
                      ),
                      delay: 3),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: FractionalOffset.bottomRight,
                  child: fadeIn_fadeOut(
                      image: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Viens découvrir de nouvelle choses',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Tous les freestyles sont réunis ici',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      delay: 3),
                ),
                const SizedBox(
                  height: 30,
                ),
                fadeIn_fadeOut(
                    image: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const change_page(),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 30, 51, 88),
                              padding: const EdgeInsets.all(13),
                            ),
                            child: Text(
                              "Connecte-toi ici ",
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor:
                                  const Color.fromARGB(255, 171, 170, 170),
                              padding: const EdgeInsets.all(13),
                            ),
                            child: Text(
                              "Inscription",
                              style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    delay: 4)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
