import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longpress_popup_example/popup_option_controls.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F8CFF),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF4F8CFF),
          secondary: const Color(0xFF00C2A8),
          surface: const Color(0xFF111827),
          onSurface: const Color(0xFFE5E7EB),
        );

    final TextTheme baseTextTheme = ThemeData(
      brightness: Brightness.dark,
    ).textTheme;

    return MaterialApp(
      title: 'Marker Popup Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        textTheme: GoogleFonts.interTextTheme(baseTextTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0B1220),
          foregroundColor: colorScheme.onSurface,
          centerTitle: true,
          titleTextStyle: GoogleFonts.jetBrainsMono(
            color: colorScheme.onSurface,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: colorScheme.surface,
          contentTextStyle: GoogleFonts.jetBrainsMono(
            color: colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const PopupOptionControls(),
    );
  }
}
