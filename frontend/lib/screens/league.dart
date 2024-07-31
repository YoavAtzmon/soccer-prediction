import 'package:flutter/material.dart';

class League extends StatelessWidget {
  final String leagueId;

  const League({Key? key, required this.leagueId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My League'),
      ),
      body: Center(
        child: Text('League $leagueId'),
      ),
    );
  }
}
