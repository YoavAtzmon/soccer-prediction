import 'package:flutter/material.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/screens/league.dart';
import 'package:namer_app/services/league_service.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';

class LeagueList extends StatefulWidget {
  const LeagueList({
    super.key,
    required this.leagueState,
  });

  final UserLeagueProvider leagueState;

  @override
  State<LeagueList> createState() => _LeagueListState();
}

class _LeagueListState extends State<LeagueList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: ListView(
          children: widget.leagueState.userLeagues.map((league) {
            return Card(
                child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return League(leagueId: league.leagueId);
                }));
              },
              title: Text(league.leagueName),
              trailing: league.isAdmin
                  ? IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                bool isLoading = false;
                                return FlutterDialog(
                                    title: 'Notice',
                                    confirmButtonText: 'Yes',
                                    loading: isLoading,
                                    showCancel: true,
                                    content: const Text(
                                        'Are you sure you want to delete this league?'),
                                    onConfirm: () async {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await LeagueService()
                                            .deleteLeague(league.leagueId);
                                        await widget.leagueState
                                            .fetchUserLeagues();
                                      } catch (e) {
                                        SnackBar(content: Text(e.toString()));
                                      } finally {
                                        if (context.mounted) {
                                          setState(() {
                                            isLoading = false;
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      }
                                    });
                              },
                            );
                          },
                        );
                      })
                  : null,
            ));
          }).toList(),
        ),
      ),
    );
  }
}
