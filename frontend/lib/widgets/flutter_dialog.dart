import 'package:flutter/material.dart';

class FlutterDialog extends StatelessWidget {
  const FlutterDialog(
      {super.key,
      required this.title,
      required this.onConfirm,
      this.content,
      this.confirmButtonText = 'Confirm',
      this.showCancel});

  final String title;
  final String? content;
  final String confirmButtonText;
  final bool? showCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content!),
        actions: <Widget>[
          if (showCancel == true)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          TextButton(onPressed: onConfirm, child: Text(confirmButtonText))
        ]);
  }
}
