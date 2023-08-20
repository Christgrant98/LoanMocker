import 'package:flutter/material.dart';

import 'base_text_form_field.dart';

class LoanAmountFormField extends StatefulWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const LoanAmountFormField({
    super.key,
    required this.onChange,
    this.initialValue,
    this.onFieldSubmitted,
  });

  @override
  State<LoanAmountFormField> createState() => _LoanAmountFormFieldState();
}

class _LoanAmountFormFieldState extends State<LoanAmountFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        BaseTextFormField(
          keyboardType: TextInputType.number,
          initialValue: widget.initialValue,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: Color.fromARGB(255, 212, 212, 212),
            hintStyle: TextStyle(
                fontFamily: 'ProductSans',
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14),
          ),
          onChanged: widget.onChange,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
