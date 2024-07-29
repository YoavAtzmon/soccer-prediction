import 'package:flutter/material.dart';
import 'package:namer_app/features/leagues/widgets/league_list.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/screens/create_league.dart';
import 'package:provider/provider.dart';

class Leagues extends StatefulWidget {
  const Leagues({Key? key}) : super(key: key);

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserLeagueProvider>().fetchUserLeagues();
    });
  }

  @override
  Widget build(BuildContext context) {
    var leagueState = context.watch<UserLeagueProvider>();
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Title(
                color: Colors.green,
                child: const Text('Leagues', style: TextStyle(fontSize: 24))),
            const SizedBox(height: 10),
            if (leagueState.isLoading)
              const CircularProgressIndicator()
            else
              LeagueList(leagueState: leagueState),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateLeagueForm()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Create new league'),
            ),
          ],
        ),
      ),
    );
  }
}
