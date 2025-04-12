import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insulation_app/firebase_options.dart';
import 'package:insulation_app/util/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('sv'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('sv')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(226, 223, 204, 145),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 250, 204, 151),
            surface: const Color.fromARGB(236, 233, 224, 197)),
        primaryColor: const Color.fromARGB(226, 223, 204, 145),
        textTheme: GoogleFonts.patrickHandTextTheme(),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}
