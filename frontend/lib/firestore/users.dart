import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> storeUserData(User user) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
      'oid': user.uid,
      // Add any other fields you want to store
    });
    print('User data stored successfully');
  } catch (e) {
    print('Error storing user data: $e');
  }
}
