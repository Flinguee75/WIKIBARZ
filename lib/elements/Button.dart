import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatefulWidget {
  final Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
