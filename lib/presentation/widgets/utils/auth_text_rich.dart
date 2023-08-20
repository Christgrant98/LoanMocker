// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthTextRich extends StatelessWidget {
  final String questionText;
  final String actionLinkText;
  final void Function() onTap;

  const AuthTextRich({
    super.key,
    required this.questionText,
    required this.actionLinkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: questionText,
        style: const TextStyle(
          fontFamily: 'ProductSans',
          color: Colors.grey,
        ),
        children: [
          TextSpan(
            text: actionLinkText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 84, 40, 241),
            ),
            recognizer: TapGestureRecognizer()..onTap = () => onTap(),
          ),
        ],
      ),
    );
  }
}
