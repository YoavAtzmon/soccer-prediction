import 'package:flutter/material.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/utils/helpers_functions.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';

class AccessCodeDialog extends StatelessWidget {
  const AccessCodeDialog({
    super.key,
    required this.league,
  });

  final LeagueProps league;

  @override
  Widget build(BuildContext context) {
    return FlutterDialog(
      title: 'League access code',
      content: Row(children: [
        Expanded(
          child: Text(league.leagueId),
        ),
        IconButton(
          onPressed: () {
            copyToClipboard(league.leagueId, context);
          },
          icon: const Icon(Icons.copy, size: 20),
        )
      ]),
      onConfirm: () {
        Navigator.of(context).pop();
      },
      confirmButtonText: 'Ok',
    );
  }
}
