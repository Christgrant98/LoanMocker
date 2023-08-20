import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(119, 158, 158, 158)),
          borderRadius: BorderRadius.circular(2.5)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          'assets/settings_button.svg',
          alignment: Alignment.topRight,
        ),
      ),
    );
  }
}
