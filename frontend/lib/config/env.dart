import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Environment { dev, prod }

class EnvironmentConfig {
  static final EnvironmentConfig _singleton = EnvironmentConfig._internal();
  factory EnvironmentConfig() => _singleton;
  EnvironmentConfig._internal();

  late Environment _environment;

  Future<void> initialize(Environment env) async {
    _environment = env;
    await Firebase.initializeApp();

    if (_environment == Environment.dev) {
      try {
        FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
        FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
        await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
      } catch (e) {
        print(e);
      }
    }
  }

  bool get isDev => _environment == Environment.dev;
  bool get isProd => _environment == Environment.prod;

  // Firebase instances
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseFunctions get functions => FirebaseFunctions.instance;
  FirebaseAuth get auth => FirebaseAuth.instance;
}
