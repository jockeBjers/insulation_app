import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insulation_app/Pages/home_page.dart';
import 'package:insulation_app/Pages/login_page.dart';
import 'package:insulation_app/services/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If user is authenticated, fetch their Firestore data
        if (snapshot.hasData && snapshot.data != null) {
          return FutureBuilder<bool>(
            future: authService.isLoggedInWithData(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // If user has Firestore data, show HomePage directly
              if (dataSnapshot.data == true) {
                return const HomePage();
              }

              // If user is authenticated but doesn't have Firestore data
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Konto inte aktiverat",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Kontot existerar men är inte konfigurerat.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          await authService.signout();
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        child: const Text("Logga ut"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        // Otherwise show Login
        return const Login();
      },
    );
  }
}
