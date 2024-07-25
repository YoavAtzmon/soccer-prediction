import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/screens/leagues.dart';
import 'package:namer_app/screens/user.dart';

class AuthenticatedApp extends StatefulWidget {
  final User user;

  const AuthenticatedApp({required this.user, Key? key}) : super(key: key);

  @override
  AuthenticatedAppState createState() => AuthenticatedAppState();
}

class AuthenticatedAppState extends State<AuthenticatedApp> {
  int _currentIndex = 0;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      UserPage(user: widget.user),
      const Leagues(),
      const Placeholder()
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Leagues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}
