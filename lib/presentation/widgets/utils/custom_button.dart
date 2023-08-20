import 'package:cw_bank_credit/presentation/widgets/utils/text_view.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 84, 40, 241),
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          elevation: 0.0,
        ),
        onPressed: onPressed,
        child: TextView(text: text, fontWeight: FontWeight.w900, fontSize: 15),
      ),
    );
  }
}
