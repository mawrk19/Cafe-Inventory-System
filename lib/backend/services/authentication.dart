import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:kopilism/backend/services/shared_preference_service.dart';
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
      if (userCredential.user != null) {
        // Fetch user data from Firestore and save it in SharedPreferences
        final userData = await getUserData(userCredential.user!.uid);
        _saveUserDataToSharedPreferences(userData);
      }
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> _fetchUserData(String userId) async {
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

    if (!userDoc.exists) {
      throw Exception('User data is null');
    }

    return userDoc;
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    return await _fetchUserData(userId);
  }

  Future<DocumentSnapshot> getCurrentUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await _fetchUserData(user.uid);
    } else {
      throw Exception('No user is currently signed in.');
    }
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

      // Fetch current admin data
      DocumentSnapshot adminData = await getCurrentUserData();
      String createdByAdminName = adminData['fullName'];
      String createdByAdminEmail = adminData['email'];

      String collectionPath = role == 'employee' ? 'employee' : 'admin';

      await _firestore.collection('users').doc(collectionPath).collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'password': hashedPassword,
        'contactNumber': contactNumber,
        'role': role,
        'pin': pin,
        'createdByAdminName': createdByAdminName, // Save admin name
        'createdByAdminEmail': createdByAdminEmail, // Save admin email
      });

      // After registration, save user data in SharedPreferences
      final userData = await getUserData(userCredential.user!.uid);
      _saveUserDataToSharedPreferences(userData);

    } catch (e) {
      rethrow;
    }
  }

  // Helper method to save user data in SharedPreferences
  Future<void> _saveUserDataToSharedPreferences(DocumentSnapshot userData) async {
    String userId = userData.id;
    String userRole = userData['role'];
    String fullName = userData['fullName'];
    String email = userData['email'];

    // Prepare a map of the data
    Map<String, String> dataToStore = {
      'userId': userId,
      'userRole': userRole,
      'fullName': fullName,
      'email': email,
    };

    // Save user data to SharedPreferences
    await SharedPreferencesService.saveMultiple(dataToStore);
  }

  // Add other authentication and Firestore methods here
}
