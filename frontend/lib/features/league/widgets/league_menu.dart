import 'package:flutter/material.dart';
import 'package:namer_app/features/league/widgets/access_code_dialog.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/utils/helpers_functions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LeagueMenu extends StatelessWidget {
  const LeagueMenu({Key? key, required this.league}) : super(key: key);
  final LeagueProps league;

  @override
  Widget build(BuildContext context) {
    var leagueState = context.watch<UserLeagueProvider>();
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'leave',
          child: const Text('Leave League'),
          onTap: () async {
            leagueState.leaveLeague(league.leagueId).then((_) {
              Navigator.of(context).pop();
            });
          },
        ),
        PopupMenuItem<String>(
          value: 'accessCode',
          enabled: isLeagueAdmin(league),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AccessCodeDialog(league: league),
          ),
          child: const Text('Show league access code'),
        ),
        PopupMenuItem<String>(
          value: 'payment',
          enabled: league.withPayment,
          onTap: () async {
            await launchUrl(Uri.parse(league.paymentLink ?? ''));
          },
          child: const Text('Go to payment'),
        ),
      ],
    );
  }
}
