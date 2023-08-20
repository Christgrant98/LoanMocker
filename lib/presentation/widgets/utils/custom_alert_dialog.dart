import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? titleText;
  final String? contentText;
  final Widget? content;
  final VoidCallback? onButtonPressed;
  final String? buttonText;
  final Widget? header;
  final List<Widget>? actions;
  final int? displayDuration;
  const CustomAlertDialog({
    Key? key,
    this.titleText,
    this.contentText,
    this.onButtonPressed,
    this.buttonText,
    this.content,
    this.header,
    this.actions,
    required this.displayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: displayDuration!), () {
      Navigator.of(context).pop();
    });

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        title: header,
        content: content,
        actions: actions,
      ),
    );
  }
}
