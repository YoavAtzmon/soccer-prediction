import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/screens/league.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';
import 'package:provider/provider.dart';

class JoinLeague extends StatefulWidget {
  const JoinLeague({Key? key}) : super(key: key);

  @override
  State<JoinLeague> createState() => _JoinLeagueState();
}

class _JoinLeagueState extends State<JoinLeague> {
  @override
  Widget build(BuildContext context) {
    var leagueState = context.watch<UserLeagueProvider>();
    String leagueCode = '';
    bool isLoading = false;

    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return FlutterDialog(
                    title: 'Join league',
                    content: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter league code',
                      ),
                      onChanged: (value) {
                        setState(() {
                          leagueCode = value;
                        });
                      },
                    ),
                    loading: isLoading,
                    showCancel: true,
                    confirmButtonText: 'Join',
                    onConfirm: leagueCode != ''
                        ? () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              leagueState.joinLeague(leagueCode).then((_) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          League(leagueId: leagueCode)),
                                );
                              });
                            } catch (e) {
                              final error = e as FirebaseFunctionsException;
                              final message = error.details['message'];
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(message),
                                  ),
                                );
                              }
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        : null);
              },
            );
          },
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('Join league'),
    );
  }
}
