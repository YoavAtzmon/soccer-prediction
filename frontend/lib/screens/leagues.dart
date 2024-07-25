import 'package:flutter/material.dart';
import 'package:namer_app/screens/create_league.dart';

class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  LeaguesState createState() => LeaguesState();
}

class LeaguesState extends State<Leagues> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Title(
              color: Colors.green,
              child: const Text('Leagues', style: TextStyle(fontSize: 24))),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateLeagueForm()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Create new league'),
          ),
        ],
      ),
    );
  }
}
