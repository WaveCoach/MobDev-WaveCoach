import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color skyBlue = Color(0xFFF1FAFF);
  static const Color deepOceanBlue = Color(0xFF3E6585);
  static const Color pastelBlue = Color(0xFF89B5D9);
  static const Color mistyBlue = Color(0xFF9EB2C2);
  static const Color charcoalGrey = Color.fromARGB(255, 48, 48, 48);
  static const Color warmSand = Color(0xFFEDC892);
  static const Color midnightNavy = Color(0xFF223340);
  static const Color softSteelBlue = Color(0xFFC1D2DD);
  static const Color goldenAmber = Color(0xFFECC791);
  static const Color roseBlush = Color(0xFFE2A7A8);
}

class AppTextStyles {
  static TextStyle primary = GoogleFonts.poppins(color: Colors.black);
  static TextStyle secondary = GoogleFonts.poppins(color: Colors.white);
  static TextStyle gray = GoogleFonts.poppins(
    color: Colors.white.withOpacity(0.5),
  );
}

class FontSize {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
}

class FontWeightStyles {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

const double defaultMargin = 30.0;
