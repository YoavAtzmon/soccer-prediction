import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/config/env.dart';
import 'package:namer_app/models/league.dart';

void copyToClipboard(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
}

bool isLeagueAdmin(LeagueProps league) {
  return league.admins.contains(EnvironmentConfig().auth.currentUser?.uid);
}
