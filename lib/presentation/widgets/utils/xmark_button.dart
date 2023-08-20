import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class XmarkButton extends StatelessWidget {
  const XmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  spreadRadius: -7,
                  color: Color.fromARGB(45, 0, 0, 0),
                  blurRadius: 4.0),
            ],
            borderRadius: BorderRadius.circular(50),
          ),
          child: SvgPicture.asset('assets/xmark_button.svg')),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
