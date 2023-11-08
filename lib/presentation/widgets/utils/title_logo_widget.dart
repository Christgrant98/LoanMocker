import 'package:loanMocker/presentation/widgets/utils/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleLogoWidget extends StatelessWidget {
  const TitleLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/cw_bank_credit.svg',
          height: 43,
          width: 43,
        ),
        const SizedBox(width: 10),
        const TextView(
            text: 'Loan Mocker',
            color: Colors.black,
            fontSize: 23.5,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
