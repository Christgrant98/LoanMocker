import 'package:loanMocker/presentation/widgets/utils/text_view.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool isAppColor;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
    required this.onPressed,
    required this.text,
    this.isAppColor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: isAppColor
            ? const Color.fromARGB(255, 0, 90, 126)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: isAppColor
            ? null
            : Border.all(color: const Color.fromARGB(255, 0, 90, 126)),
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
        child: TextView(
          text: text,
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color:
              isAppColor ? Colors.white : const Color.fromARGB(255, 0, 90, 126),
        ),
      ),
    );
  }
}
