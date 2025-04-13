// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:insulation_app/models/organization/organization.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:insulation_app/models/users/user.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Organization methods
  Future<List<Organization>> getOrganizations() async {
    final snapshot = await _firestore.collection('organizations').get();
    return snapshot.docs.map((doc) => Organization.fromFirestore(doc)).toList();
  }

  Future<Organization?> getOrganization(String id) async {
    final doc = await _firestore.collection('organizations').doc(id).get();
    if (doc.exists) {
      return Organization.fromFirestore(doc);
    }
    return null;
  }

  Future<String> createOrganization(Organization organization) async {
    final docRef = await _firestore
        .collection('organizations')
        .add(organization.toFirestore());
    return docRef.id;
  }

  Future<void> updateOrganization(Organization organization) async {
    await _firestore
        .collection('organizations')
        .doc(organization.id)
        .update(organization.toFirestore());
  }

  Future<void> deleteOrganization(String id) async {
    await _firestore.collection('organizations').doc(id).delete();
  }

  // User methods
  Future<User?> getCurrentUser() async {
    try {
      final authUser = _auth.currentUser;
      if (authUser == null) {
        print('No authenticated user found');
        return null;
      }

      print('Auth user ID: ${authUser.uid}');
      final doc = await _firestore.collection('users').doc(authUser.uid).get();

      if (doc.exists) {
        final userData = doc.data() as Map<String, dynamic>;
        print('User document data: $userData');

        final user = User.fromFirestore(doc);
        print('Parsed user: ${user.toJson()}');
        return user;
      } else {
        print('User document does not exist for ID: ${authUser.uid}');
      }
      return null;
    } catch (e) {
      print('Error in getCurrentUser: $e');
      return null;
    }
  }

  Future<User?> getUserById(String id) async {
    final doc = await _firestore.collection('users').doc(id).get();
    if (doc.exists) {
      return User.fromFirestore(doc);
    }
    return null;
  }

  Future<List<User>> getUsersByOrganization(String organizationId) async {
    final snapshot = await _firestore
        .collection('users')
        .where('organizationId', isEqualTo: organizationId)
        .get();
    return snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  Future<void> updateUser(User user) async {
    await _firestore
        .collection('users')
        .doc(user.id)
        .update(user.toFirestore());
  }

  Future<void> createUserProfile(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toFirestore());
  }

  // Project methods
  Future<List<Project>> getProjects(String organizationId) async {
    print(
        'Querying Firestore for projects with organizationId: $organizationId');
    try {
      final snapshot = await _firestore
          .collection('projects')
          .where('organizationId', isEqualTo: organizationId)
          .get();
      print('Firestore query returned ${snapshot.docs.length} projects');

      // Debug: For empty results, let's check if there are any projects at all
      if (snapshot.docs.isEmpty) {
        print(
            'No projects found for organization $organizationId, checking if any projects exist...');
        final allProjects = await _firestore.collection('projects').get();
        print('Total projects in collection: ${allProjects.docs.length}');

        // If there are projects, let's check their organizationIds
        if (allProjects.docs.isNotEmpty) {
          print('Existing projects have these organizationIds:');
          for (var doc in allProjects.docs) {
            final data = doc.data();
            print(
                'Project ${doc.id}: organizationId = ${data['organizationId']}');
          }
        }
      }

      return snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error in getProjects: $e');
      return [];
    }
  }

  // Get all projects (without organization filter)
  Future<List<Project>> getAllProjects() async {
    final snapshot = await _firestore.collection('projects').get();
    return snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
  }

  Future<Project?> getProject(String id) async {
    final doc = await _firestore.collection('projects').doc(id).get();
    if (doc.exists) {
      return Project.fromFirestore(doc);
    }
    return null;
  }

  Future<String> createProject(Project project) async {
    try {
      final Map<String, dynamic> data = project.toFirestore();
      print('Creating new project with data:');
      print('Project name: ${data['name']}');
      print('Organization ID: ${data['organizationId']}');

      final docRef = await _firestore.collection('projects').add(data);
      print('Project created successfully with ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('Error creating project: $e');
      rethrow;
    }
  }

  Future<void> updateProject(Project project) async {
    try {
      final Map<String, dynamic> data = project.toFirestore();
      print('Updating project: ${project.id} with data: $data');

      // Log the structure of pipes for debugging
      if (data.containsKey('pipes')) {
        print('Pipes data structure: ${data['pipes']}');
      }

      await _firestore.collection('projects').doc(project.id).update(data);

      print('Project updated successfully');
    } catch (e) {
      print('Error updating project: $e');
      rethrow;
    }
  }

  Future<void> deleteProject(String id) async {
    await _firestore.collection('projects').doc(id).delete();
  }

  // Authentication methods
  Future<auth.UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<auth.UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  auth.User? get currentAuthUser => _auth.currentUser;

  Stream<auth.User?> get authStateChanges => _auth.authStateChanges();
}
