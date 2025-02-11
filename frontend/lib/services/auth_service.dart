import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namer_app/config/env.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = EnvironmentConfig().auth;
  Future<void> signInWithGoogle() async {
    // Implement Google Sign In
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    await _auth.signOut();
  }
}
