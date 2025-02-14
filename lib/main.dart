import 'package:flutter/material.dart';
import 'package:insulation_app/Pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(226, 223, 204, 145),
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 250, 204, 151),
            surface: const Color.fromARGB(236, 233, 224, 197)),
        primaryColor: const Color.fromARGB(226, 223, 204, 145),
        textTheme: GoogleFonts.patrickHandTextTheme(),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
