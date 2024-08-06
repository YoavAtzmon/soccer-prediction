import 'dart:io';
import 'package:flutter/material.dart';
import 'package:namer_app/features/league/widgets/league_menu.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/models/user.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:provider/provider.dart';

class League extends StatefulWidget {
  final String leagueId;

  const League({Key? key, required this.leagueId}) : super(key: key);

  @override
  State<League> createState() => _LeagueState();
}

class _LeagueState extends State<League> {
  @override
  Widget build(BuildContext context) {
    var leagueState = context.watch<UserLeagueProvider>();
    if (!leagueState.leagueExists(widget.leagueId)) {
      return const CircularProgressIndicator();
    }
    return FutureBuilder(
      future: leagueState.getLeagueUsers(widget.leagueId),
      builder: (context, AsyncSnapshot<List<UserProps?>> snapshot) {
        final LeagueProps league = leagueState.getLeague(widget.leagueId);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('League'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome to : ${league.leagueName}'),
                  LeagueMenu(league: league),
                  league.leaguePhotoURL == ''
                      ? const SizedBox.shrink()
                      : Image.file(
                          File(league.leaguePhotoURL ?? ''),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  LeagueUsersList(
                    snapshot: snapshot,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class LeagueUsersList extends StatelessWidget {
  const LeagueUsersList({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<List<UserProps?>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final user = snapshot.data![index];
          return ListTile(
            title: Text(user?.displayName ?? ''),
          );
        },
      ),
    );
  }
}
