// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:insulation_app/Pages/projects_page.dart';
import 'package:insulation_app/services/auth_service.dart';
import 'package:insulation_app/services/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  bool _hasProjects = false;

  @override
  void initState() {
    super.initState();
    _checkProjects();
  }

  Future<void> _checkProjects() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get current user to get their organization
      final currentUser = await _firebaseService.getCurrentUser();

      if (currentUser != null) {
        print('Current user: ${currentUser.name}, role: ${currentUser.role}');
        print('Organization ID: ${currentUser.organizationId}');

        // Check if there are any projects
        if (currentUser.organizationId.isNotEmpty) {
          final projects =
              await _firebaseService.getProjects(currentUser.organizationId);
          setState(() {
            _hasProjects = projects.isNotEmpty;
          });
          print('Found ${projects.length} projects for this organization');
        } else {
          final projects = await _firebaseService.getAllProjects();
          setState(() {
            _hasProjects = projects.isNotEmpty;
          });
          print('Loaded ${projects.length} projects (all organizations)');
        }
      } else {
        print('Warning: No current user found');
        final projects = await _firebaseService.getAllProjects();
        setState(() {
          _hasProjects = projects.isNotEmpty;
        });
      }
    } catch (e) {
      print('Error checking projects: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToProjects() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProjectsPage()),
    ).then((_) {
      // Refresh when returning to home
      _checkProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Laddar...")),
        body:
            Center(child: CircularProgressIndicator(color: theme.primaryColor)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ISOLERAMERA",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            tooltip: 'Logga ut',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: .05),
              theme.colorScheme.primary.withValues(alpha: .2),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TODO: real logo
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: .3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.construction,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 40),

                      Text(
                        "Välkommen till Isoleringsberäknaren",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 16),

                      Text(
                        "Räkna på isolering och hantera projekt enkelt och effektivt",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 60),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        onPressed: _navigateToProjects,
                        icon: Icon(
                          _hasProjects ? Icons.business : Icons.add_business,
                          size: 24,
                        ),
                        label: Text(_hasProjects
                            ? "Visa projekt"
                            : "Skapa ditt första projekt"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Footer
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  "© 2025 Isoleramera",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
