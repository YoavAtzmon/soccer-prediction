import 'dart:io';

import 'package:flutter/material.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/models/user.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return FutureBuilder(
      future: leagueState.getLeagueUsers(widget.leagueId),
      builder: (context, AsyncSnapshot<List<UserProps?>> snapshot) {
        final LeagueProps? league = leagueState.getLeague(widget.leagueId);

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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('No users in this league.'),
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
                  Text('Welcome to : ${league?.leagueName}'),
                  league?.leaguePhotoURL == ''
                      ? const SizedBox.shrink()
                      : Image.file(
                          File(league?.leaguePhotoURL ?? ''),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        return ListTile(
                          title: Text(user?.displayName ?? ''),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      leagueState.leaveLeague(widget.leagueId).then((_) {
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
      },
    );
  }
}
