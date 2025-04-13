import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insulation_app/Pages/home_page.dart';
import 'package:insulation_app/Pages/login_page.dart';
import 'package:insulation_app/Pages/project_detail_page.dart';
import 'package:insulation_app/firebase_options.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:insulation_app/theme/app_theme.dart';
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
      theme: AppTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const Login(),
      },
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name!.startsWith('/project/')) {
          final projectId = settings.name!.substring('/project/'.length);
          final project = settings.arguments as Project?;

          if (project != null) {
            return MaterialPageRoute(
              builder: (context) => ProjectDetailPage(project: project),
            );
          }
        }

        // Return null for unknown routes
        return null;
      },
    );
  }
}
