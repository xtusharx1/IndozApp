import 'package:flutter/material.dart';

class IndozTheme {
  // Primary Colors
  static const Color gradientStart = Color(0xFF1a2332); // deep navy blue
  static const Color gradientEnd = Color(0xFF2d1b3d); // dark purple
  static const Color accentOrange = Color(0xFFFF7A00);

  // Neutral Colors
  static const Color cardBackground = Colors.white;
  static const Color lightGrayBackground = Color(0xFFF5F5F5);
  static const Color inputBackground = Color(0xFFFAFAFA);
  static const Color borderColor = Color(0xFFE0E0E0);

  // Text Colors
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
  static const Color hintText = Color(0xFFBDBDBD);

  // Gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: accentOrange,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Inter',

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: accentOrange,
      secondary: accentOrange,
      surface: cardBackground,
      error: Color(0xFFD32F2F),
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: primaryText,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      titleLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: primaryText,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: secondaryText,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: secondaryText,
      ),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(
        color: hintText,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentOrange, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD32F2F)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentOrange,
        foregroundColor: Colors.white,
        disabledBackgroundColor: accentOrange.withOpacity(0.6),
        disabledForegroundColor: Colors.white.withOpacity(0.7),
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentOrange,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: secondaryText, size: 24),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryText,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  // Helper Methods
  static BoxDecoration gradientBackground() {
    return const BoxDecoration(gradient: backgroundGradient);
  }

  static BoxDecoration cardDecoration({double radius = 24}) {
    return BoxDecoration(
      color: cardBackground,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static BoxDecoration lightCardDecoration({double radius = 24}) {
    return BoxDecoration(
      color: lightGrayBackground,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
