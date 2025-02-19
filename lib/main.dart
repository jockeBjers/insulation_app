import 'package:flutter/material.dart';
import 'package:insulation_app/Pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insulation_app/models/insulated_pipe.dart';
import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';
import 'package:insulation_app/models/project.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(InsulationTypeAdapter());
  Hive.registerAdapter(PipeSizeAdapter());
  Hive.registerAdapter(InsulatedPipeAdapter());
  Hive.registerAdapter(ProjectAdapter());

  await Hive.openBox<Project>('projects');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('sv'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en'), const Locale('sv')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(226, 223, 204, 145),
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
      home: HomePage(),
    );
  }
}
