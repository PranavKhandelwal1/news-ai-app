// lib/features/auth/data/auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Register user and store profile in Firestore
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) async {

    print("STEP 1: Entered signUp()");

    final credential =
    await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    print("STEP 2: User created in Firebase Auth");

    final user = credential.user;

    if (user != null) {
      try {
        print("STEP 3: Writing Firestore document");

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'name': name,
          'email': user.email,
          'isPremium': false,
          'createdAt': Timestamp.now(),
        });

        print("STEP 4: Firestore write completed");

      } catch (e) {
        print("FIRESTORE ERROR:");
        print(e);
        rethrow;
      }
    }

    print("STEP 5: Signup finished");

    return credential;
  }

  /// Returns currently logged in user
  User? get currentUser => _auth.currentUser;

  /// Login existing user
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  /// Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}