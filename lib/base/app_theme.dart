import 'package:flutter/material.dart';

class AppTheme {
  // ─── Color Palette ───────────────────────────────────────
  static const Color deepTeal      = Color(0xFF0F4C5C); // Background / AppBar
  static const Color aquaBlue      = Color(0xFF1ED8C1); // Buttons / Highlights
  static const Color softTeal      = Color(0xFF087E8B); // Icons / Active tabs
  static const Color white         = Color(0xFFFFFFFF); // Primary text on dark
  static const Color charcoalGrey  = Color(0xFF1C1C1E); // Primary text on light
  static const Color lightGrey     = Color(0xFFB0B0B0); // Subtle text
  static const Color softRed       = Color(0xFFE63946); // Errors
  static const Color mintGreen     = Color(0xFF3FB984); // Success

  // ─── Common TextTheme ────────────────────────────────────
  static const TextTheme _textThemeDark = TextTheme(
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: white),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: aquaBlue),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: white),
    labelLarge:    TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: white),
  );

  static const TextTheme _textThemeLight = TextTheme(
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: white),
    // headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: charcoalGrey),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: softTeal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: charcoalGrey),
    labelLarge:    TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: softTeal),
  );

  // ─── Dark Theme ──────────────────────────────────────────
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: deepTeal,
    scaffoldBackgroundColor: deepTeal,
    cardColor: const Color(0xFF1A3B45),
    colorScheme: ColorScheme.dark(
      primary: aquaBlue,
      secondary: softTeal,
      error: softRed,
      background: deepTeal,
      onPrimary: white,
      onBackground: white,
    ),
    appBarTheme:   AppBarTheme(backgroundColor: deepTeal, iconTheme: const IconThemeData(color: white)),
    textTheme:     _textThemeDark,
    iconTheme:     const IconThemeData(color: softTeal),
    dividerColor:  lightGrey.withOpacity(0.6),
    snackBarTheme: SnackBarThemeData(backgroundColor: charcoalGrey, contentTextStyle: _textThemeDark.bodyMedium),
    dialogBackgroundColor: const Color(0xFF1A3B45),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: white, backgroundColor: aquaBlue,
        textStyle: _textThemeDark.labelLarge,
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: aquaBlue, side: BorderSide(color: aquaBlue),
        backgroundColor: white,
        textStyle: _textThemeDark.labelLarge?.copyWith(color: aquaBlue),
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  // ─── Light Theme ─────────────────────────────────────────
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: deepTeal,
    scaffoldBackgroundColor: white,
    cardColor: white,
    colorScheme: ColorScheme.light(
      primary: deepTeal,
      secondary: softTeal,
      error: softRed,
      background: white,
      onPrimary: white,
      onBackground: charcoalGrey,
    ),
    appBarTheme:   AppBarTheme(backgroundColor: deepTeal, iconTheme: const IconThemeData(color: white)),
    textTheme:     _textThemeLight,
    iconTheme:     const IconThemeData(color: softTeal),
    dividerColor:  lightGrey,
    snackBarTheme: SnackBarThemeData(backgroundColor: charcoalGrey, contentTextStyle: _textThemeLight.bodyMedium),
    dialogBackgroundColor: white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: white, backgroundColor: aquaBlue,
        textStyle: _textThemeLight.labelLarge,
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: aquaBlue, side: BorderSide(color: aquaBlue),
        backgroundColor: white,
        textStyle: _textThemeLight.labelLarge?.copyWith(color: aquaBlue),
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
