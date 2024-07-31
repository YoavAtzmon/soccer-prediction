import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/services/league_service.dart';
import 'package:namer_app/utils/helpers_functions.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormBuilderState> formKey;
  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final formKey = widget.formKey;
    var leagueState = context.watch<UserLeagueProvider>();
    onFormSubmit() async {
      if (formKey.currentState!.saveAndValidate()) {
        setState(() {
          isLoading = true;
        });
        final formData = formKey.currentState!.value;
        final leagueProps = LeagueProps.fromMap(formData);
        LeagueService().createLeague(leagueProps).then((value) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FlutterDialog(
                  title: 'League created successfully',
                  content: Row(children: [
                    Expanded(
                      child: Text('League access code: $value'),
                    ),
                    IconButton(
                      onPressed: () {
                        copyToClipboard(value, context);
                      },
                      icon: const Icon(Icons.copy, size: 20),
                    )
                  ]),
                  onConfirm: () {
                    leagueState.fetchUserLeagues().then((_) {
                      Navigator.of(context).pop();
                    });
                  },
                );
              }).then((_) {
            Navigator.of(context).pop();
          });
        }).catchError((error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }).whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
      }
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ElevatedButton(
      onPressed: onFormSubmit,
      child: const Text('Create League'),
    );
  }
}
