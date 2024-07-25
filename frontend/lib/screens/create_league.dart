import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';

class CreateLeagueForm extends StatefulWidget {
  const CreateLeagueForm({Key? key}) : super(key: key);
  @override
  State<CreateLeagueForm> createState() => _CreateLeagueFormState();
}

class _CreateLeagueFormState extends State<CreateLeagueForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create League')),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'leagueName',
                    decoration: const InputDecoration(labelText: 'League Name'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderSwitch(
                    name: 'limitParticipants',
                    title: const Text('Limit Participants Number'),
                  ),
                  FormBuilderField(
                    name: 'participantLimitField',
                    builder: (FormFieldState<dynamic> field) {
                      final limitParticipants = _formKey.currentState
                              ?.fields['limitParticipants']?.value as bool? ??
                          false;
                      if (limitParticipants) {
                        return FormBuilderTextField(
                          name: 'participantLimit',
                          decoration: const InputDecoration(
                              labelText: 'Participant Limit'),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.numeric(),
                          ]),
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Return an empty widget when condition is false
                      }
                    },
                  ),
                  FormBuilderSwitch(
                    name: 'needsAccessCode',
                    title: Row(
                      children: [
                        const Text('Requires Access Code'),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 20),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FlutterDialog(
                                    title: 'Access Code Information',
                                    confirmButtonText: 'Got it',
                                    content:
                                        'If enabled, users will need to enter an access code to join this league. This helps keep your league private and exclusive.',
                                    onConfirm: () =>
                                        Navigator.of(context).pop());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  FormBuilderSwitch(
                    name: 'includesPay',
                    title: Row(
                      children: [
                        const Text('Includes Payment'),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 20),
                          onPressed: () => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FlutterDialog(
                                    title: 'Payment Information',
                                    confirmButtonText: 'Got it',
                                    content:
                                        'If enabled, You can set the payment link in the next step.',
                                    onConfirm: () =>
                                        Navigator.of(context).pop());
                              },
                            )
                          },
                        )
                      ],
                    ),
                  ),
                  FormBuilderField(
                    name: 'paymentLink',
                    builder: (FormFieldState<dynamic> field) {
                      final withPay = _formKey.currentState
                              ?.fields['includesPay']?.value as bool? ??
                          false;
                      if (withPay) {
                        return FormBuilderTextField(
                          name: 'paymentLink',
                          decoration: const InputDecoration(
                              labelText: 'Payment Link (Bit or Paybox)'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.url(),
                          ]),
                          keyboardType: TextInputType.url,
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Return an empty widget when condition is false
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Create League'),
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final formData = _formKey.currentState!.value;
                        print(formData);
                        // FirebaseFirestore.instance.collection('leagues').add(formData).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('League created successfully')));
                        // }).catchError((error) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create league: $error')));
                        // });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
