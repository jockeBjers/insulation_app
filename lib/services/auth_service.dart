// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insulation_app/Pages/home_page.dart';
import 'package:insulation_app/Pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insulation_app/models/users/user.dart' as app;

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  // Constructor that allows dependency injection for testing
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // Current authenticated Firebase user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current user data from Firestore
  app.User? _currentUserData;
  app.User? get currentUserData => _currentUserData;

  // Sign in with email and password
  Future<bool> signin({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Fetch associated user data from Firestore
        await fetchUserData(user.uid);

        // If context is provided, navigate to HomePage
        if (context != null) {
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
            );
          }
        }

        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Please try again later.';
      } else {
        message = e.message ?? 'An error occurred';
      }

      print('Auth Error: $message');
      throw FirebaseAuthException(
        code: e.code,
        message: message,
      );
    } catch (e) {
      print('Unexpected Error: $e');
      rethrow;
    }
  }

  // Fetch user data from Firestore based on auth UID
  Future<app.User?> fetchUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        _currentUserData = app.User.fromFirestore(doc);
        return _currentUserData;
      } else {
        print('User document not found in Firestore for UID: $uid');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // Get user's organization data
  Future<Map<String, dynamic>?> getUserOrganization() async {
    if (_currentUserData == null) {
      return null;
    }

    try {
      final doc = await _firestore
          .collection('organizations')
          .doc(_currentUserData!.organizationId)
          .get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting organization data: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signout({BuildContext? context}) async {
    _currentUserData = null;
    await _auth.signOut();

    // If context is provided, navigate to Login page
    if (context != null) {
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Login()));
      }
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Password Reset Error: ${e.message}');
      rethrow;
    }
  }

  // Check if user is logged in and has Firestore data
  Future<bool> isLoggedInWithData() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    // If we don't have user data yet, try to fetch it
    _currentUserData ??= await fetchUserData(user.uid);

    return _currentUserData != null;
  }
}
