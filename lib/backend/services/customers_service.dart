import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:kopilism/backend/services/shared_preference_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CustomersService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPasswordResetEmail(String email) async {
    print('Sending password reset email to: $email');
    await _auth.sendPasswordResetEmail(email: email);
    print('Password reset email sent successfully to: $email');
  }

  Future<User?> login(String email, String password) async {
    try {
      print('Attempting to login user with email: $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Login successful for user: ${userCredential.user?.uid}');
      return userCredential.user;
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getCustomerData(String userId) async {
    print('Fetching customer data for userId: $userId');
    DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc('customers')
        .collection('users')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      print('Customer data retrieved successfully for userId: $userId');
      print('Customer data: ${userDoc.data()}');
    } else {
      print('No customer data found for userId: $userId');
    }

    return userDoc;
  }

  Future<DocumentSnapshot> getCurrentCustomerData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      print('Fetching current customer data for signed-in user: ${user.uid}');
      return await getCustomerData(user.uid);
    } else {
      print('No customer is currently signed in.');
      throw Exception('No customer is currently signed in.');
    }
  }

  Future<void> registerCustomer({
  required String ownerName,
  required String ownerInformation,
  required String email,
  required String password,
  required String contactNumber,
  required String branchNumber,
  required DateTime dateEstablished,
  required String region,
  required String province,
  required String city,
  required String baranggay,
  required String address,
}) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String hashedPassword = sha256.convert(utf8.encode(password)).toString();

    // Reuse SharedPreferencesService
    final adminName = await SharedPreferencesService.getString('email') ?? 'Unknown';
    final adminRole = await SharedPreferencesService.getString('userRole') ?? 'Unknown';

    await _firestore.collection('users').doc('customers').collection('users').doc(userCredential.user!.uid).set({
      'ownerName': ownerName,
      'ownerInformation': ownerInformation,
      'email': email,
      'password': hashedPassword,
      'contactNumber': contactNumber,
      'branchNumber': branchNumber,
      'dateEstablished': dateEstablished,
      'region': region,
      'province': province,
      'city': city,
      'baranggay': baranggay,
      'address': address,
      'createdByAdminName': adminName,
      'createdByAdminRole': adminRole,
    });

    print('Customer document created for userId: ${userCredential.user!.uid}');
  } catch (e) {
    rethrow;
  }


  }

  Future<List<Map<String, dynamic>>> getAllCustomers() async {
    print('Fetching all customers from Firestore...');
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc('customers')
        .collection('users')
        .get();

    print('Total customers retrieved: ${querySnapshot.docs.length}');
    for (var doc in querySnapshot.docs) {
      print('Customer Data: ${doc.data()}');
    }

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
