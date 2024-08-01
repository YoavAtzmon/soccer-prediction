import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:namer_app/features/create_league/widgets/submit_button.dart';
import 'package:namer_app/widgets/info_dialog.dart';

class CreateLeagueForm extends StatelessWidget {
  CreateLeagueForm({super.key});
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
                    name: 'withPayment',
                    title: const Row(
                      children: [
                        Text('Includes Payment'),
                        InfoDialog(
                            title: 'Include Payment Information',
                            content:
                                'If enabled, You can set the payment link in the next step.')
                      ],
                    ),
                  ),
                  FormBuilderField(
                    name: 'paymentLinkField',
                    builder: (FormFieldState<dynamic> field) {
                      final withPay = _formKey.currentState
                              ?.fields['withPayment']?.value as bool? ??
                          false;
                      if (withPay) {
                        return FormBuilderTextField(
                          name: 'paymentLink',
                          initialValue:
                              'https://payboxapp.page.link/3afd1JnY2FtQPRv27',
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
                  SubmitButton(formKey: _formKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
