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
    // Create the user in Firebase Authentication
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Hash the password for security
    String hashedPassword = sha256.convert(utf8.encode(password)).toString();

    // Retrieve the current admin's details from SharedPreferences
    Map<String, String?> adminDetails = await SharedPreferencesService.getMultiple([
      'fullName',
      'email',
    ]);

    String? createdByAdminName = adminDetails['fullName'];
    String? createdByAdminEmail = adminDetails['email'];

    if (createdByAdminName == null || createdByAdminEmail == null) {
      throw Exception('Admin details not found in SharedPreferences');
    }

    // Determine the collection path based on the role
    String collectionPath = role == 'employee' ? 'employee' : 'admin';

    // Save the new user's data in Firestore
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

    // Do not save the registered user's data into SharedPreferences
  } catch (e) {
    print('Registration error: $e'); // Logging for debugging
    rethrow;
  }
}

  Future<void> updateUserProfile(String fullName, String email) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc('admin').collection('users').doc(user.uid).update({
        'fullName': fullName,
        'email': email,
      });
      await SharedPreferencesService.saveMultiple({
        'fullName': fullName,
        'email': email,
      });
    } else {
      throw Exception('No user is currently signed in.');
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
}
