import 'package:flutter/material.dart';

class FlutterDialog extends StatelessWidget {
  const FlutterDialog(
      {super.key,
      required this.title,
      required this.onConfirm,
      this.content,
      this.confirmButtonText = 'Confirm',
      this.showCancel,
      this.loading});

  final String title;
  final Widget? content;
  final String confirmButtonText;
  final bool? showCancel;
  final bool? loading;
  final dynamic onConfirm;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(title), content: content!, actions: <Widget>[
      if (showCancel == true)
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      if (loading == true)
        const CircularProgressIndicator()
      else
        TextButton(onPressed: onConfirm, child: Text(confirmButtonText))
    ]);
  }
}
