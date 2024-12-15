import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc('admin')
        .collection('users')
        .doc(userId)
        .get();

    if (!userDoc.exists) {
      userDoc = await _firestore
          .collection('users')
          .doc('employee')
          .collection('users')
          .doc(userId)
          .get();
    }

    return userDoc;
  }

  Future<void> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String contactNumber,
    required String role,
    String? pin,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String hashedPassword = sha256.convert(utf8.encode(password)).toString();

      String collectionPath = role == 'employee' ? 'employee' : 'admin';

      await _firestore.collection('users').doc(collectionPath).collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'password': hashedPassword,
        'contactNumber': contactNumber,
        'role': role,
        'pin': pin,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Add other authentication and Firestore methods here
}
