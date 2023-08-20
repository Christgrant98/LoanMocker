import 'package:flutter/material.dart';

import 'base_text_form_field.dart';

class LoanAmountFormField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        BaseTextFormField(
          keyboardType: TextInputType.number,
          initialValue: initialValue,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: const Color.fromARGB(255, 212, 212, 212),
            hintText: initialValue ?? '\$ 1\'000.000,00',
            hintStyle: const TextStyle(
                fontFamily: 'ProductSans',
                color: Color.fromARGB(255, 71, 71, 71),
                fontSize: 12),
          ),
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
