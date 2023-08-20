import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        FontStyle,
        FontWeight,
        StatelessWidget,
        Text,
        TextAlign,
        TextDecoration,
        TextStyle,
        Widget;

class TextView extends StatelessWidget {
  final String? text;
  final String? fontFamily;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  const TextView({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.fontFamily = 'ProductSans',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: textAlign,
      style: TextStyle(
        fontStyle: fontStyle,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: decoration,
      ),
    );
  }
}
