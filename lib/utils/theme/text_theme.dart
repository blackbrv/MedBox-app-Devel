import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mtextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: Colors.black54,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.montserrat(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.montserrat(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: GoogleFonts.montserrat(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.montserrat(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.white70,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: Colors.white54,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.montserrat(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.montserrat(
      color: Colors.white54,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: GoogleFonts.montserrat(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.montserrat(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
    ),
  );
}
