import 'package:flutter/material.dart';
import 'package:namer_app/features/my_leagues/widgets/join_league.dart';
import 'package:namer_app/features/my_leagues/widgets/league_list.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/screens/create_league.dart';
import 'package:provider/provider.dart';

class MyLeagues extends StatefulWidget {
  const MyLeagues({Key? key}) : super(key: key);

  @override
  State<MyLeagues> createState() => _MyLeaguesState();
}

class _MyLeaguesState extends State<MyLeagues> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My League'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leagueState.isLoading)
              const CircularProgressIndicator()
            else if (leagueState.userLeagues.isEmpty)
              const Text('No leagues found')
            else
              LeagueList(leagueState: leagueState),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  const JoinLeague(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateLeagueForm()),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create new league'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
