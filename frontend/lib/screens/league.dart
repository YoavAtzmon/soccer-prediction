import 'package:flutter/material.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class League extends StatelessWidget {
  final String leagueId;

  const League({Key? key, required this.leagueId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var leagueState = context.watch<UserLeagueProvider>();
    final LeagueProps? league = leagueState.getLeague(leagueId);
    print('league: ${league?.leagueName}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('League'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to : ${league?.leagueName}'),
            ElevatedButton(
              onPressed: () async {
                print('League id: ${league?.leagueId}');
                leagueState.leaveLeague(leagueId).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Leave League'),
            ),
            if (league?.withPayment ?? false)
              ElevatedButton(
                onPressed: () async {
                  await launchUrl(Uri.parse(league?.paymentLink ?? ''));
                },
                child: const Text('Pay League'),
              ),
          ],
        ),
      ),
    );
  }
}

//https://payboxapp.page.link/3afd1JnY2FtQPRv27
