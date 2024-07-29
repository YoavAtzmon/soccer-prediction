import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/services/league_service.dart';
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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ElevatedButton(
      child: const Text('Create League'),
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        if (formKey.currentState!.saveAndValidate()) {
          final formData = formKey.currentState!.value;
          final leagueProps = LeagueProps.fromMap(formData);
          LeagueService().createLeague(leagueProps).then((value) {
            print('value: $value');
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('League created successfully')));
            leagueState.fetchUserLeagues().then((_) {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
            }).catchError((error) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          });
        }
      },
    );
  }
}
