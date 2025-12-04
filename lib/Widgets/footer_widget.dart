import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 0.10 * height,
      width: width,
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        "${DateTime.now().year} PASS DVLA APP",
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
