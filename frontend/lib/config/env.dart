import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Environment { dev, prod }

class EnvironmentConfig {
  static final EnvironmentConfig _singleton = EnvironmentConfig._internal();
  factory EnvironmentConfig() => _singleton;
  EnvironmentConfig._internal();

  static late FirebaseApp firebaseApp;

  Future<void> initialize() async {
    bool isProduction = const bool.fromEnvironment('dart.vm.product');
    firebaseApp = await Firebase.initializeApp();
    if (!isProduction) {
      try {
        FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
        FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
        await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
      } catch (e) {
        print(e);
      }
    }
  }

  // Firebase instances
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseFunctions get functions => FirebaseFunctions.instance;
  FirebaseAuth get auth => FirebaseAuth.instance;
}
