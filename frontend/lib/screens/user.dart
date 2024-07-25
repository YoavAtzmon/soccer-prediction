import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/auth_service.dart';

class UserPage extends StatelessWidget {
  final User user;

  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name = user.displayName;
    String? email = user.email;
    String? photoUrl = user.photoURL;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text('Welcome, ${name ?? 'User'}!'),
            Text('Email: ${email ?? 'N/A'}'),
            ElevatedButton(
              onPressed: () async {
                await GoogleAuthService().signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
