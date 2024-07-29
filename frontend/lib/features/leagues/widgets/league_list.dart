import 'package:flutter/material.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/services/league_service.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';

class LeagueList extends StatelessWidget {
  const LeagueList({
    super.key,
    required this.leagueState,
  });

  final UserLeagueProvider leagueState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: leagueState.userLeagues.map((league) {
          return Card(
              child: ListTile(
            title: Text(league.leagueName),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FlutterDialog(
                        title: 'Notice',
                        confirmButtonText: 'Yes',
                        showCancel: true,
                        content: 'Are you sure you want to delete this league?',
                        onConfirm: () async {
                          await LeagueService().deleteLeague(league.leagueId);
                          await leagueState.fetchUserLeagues();
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        });
                  },
                );
              },
            ),
          ));
        }).toList(),
      ),
    );
  }
}
