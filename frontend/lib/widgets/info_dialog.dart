import 'package:flutter/material.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    super.key,
    this.title = 'Information',
    required this.content,
    this.confirmButtonText = 'Got it',
    this.icon = Icons.info_outline,
  });

  final String title;
  final String content;
  final String confirmButtonText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 20),
      onPressed: () => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FlutterDialog(
                title: title,
                confirmButtonText: confirmButtonText,
                content: Text(content),
                onConfirm: () => Navigator.of(context).pop());
          },
        )
      },
    );
  }
}
