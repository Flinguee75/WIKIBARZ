import 'package:conspirapcy/animation/Fade_Animation.dart';
import 'package:conspirapcy/elements/CircleBox.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

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
    _controller = VideoPlayerController.asset('images/grunt.mp4')
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
            margin: const EdgeInsets.symmetric(
              vertical: 70,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: fadeIn_fadeOut(
                    image: Image.asset(
                      'images/titre.png',
                      width: 300,
                    ),
                    delay: 2,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.topLeft,
                  child: CircleBox(
                    height: 300,
                    width: 200,
                    widget: Image.asset('images/logo1.png'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: FractionalOffset.bottomRight,
                  child: Text(
                    'Viens Découvrir de nouvelle choses',
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 64, 105, 175),
                      padding: const EdgeInsets.all(13),
                    ),
                    child: Text(
                      "Connecte-toi ici frérot",
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
