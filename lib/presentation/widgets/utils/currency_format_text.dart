import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'text_view.dart';

class CurrencyFormattedText extends StatelessWidget {
  final double amount;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;

  const CurrencyFormattedText({
    super.key,
    required this.amount,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '',
    );
    String formattedAmount = currencyFormat.format(amount);

    return TextView(
      text: '\$ $formattedAmount',
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
    );
  }
}
