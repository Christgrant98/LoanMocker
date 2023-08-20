// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cw_bank_credit/presentation/widgets/utils/base_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_view.dart';

class LoanTermFormField extends StatefulWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const LoanTermFormField({
    Key? key,
    required this.onChange,
    this.initialValue,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<LoanTermFormField> createState() => _LoanTermFormFieldState();
}

class _LoanTermFormFieldState extends State<LoanTermFormField> {
  @override
  Widget build(BuildContext context) {
    int minTerm = 12;
    int maxTerm = 84;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
          text: 'A cuantos meses?',
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        BaseTextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2)
          ],
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: '48',
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 190, 190, 190),
                fontSize: 12,
                fontFamily: 'ProductSans',
              ),
              helperStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w300,
                fontFamily: 'ProductSans',
              ),
              helperText: 'Elige un plazo desde 12 hasta 84 meses',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white),
          onChanged: widget.onChange,
          validator: (value) {
            final int enteredValue = int.tryParse(value!) ?? -1;
            if (enteredValue < minTerm || enteredValue > maxTerm) {
              return 'Ingresa un número entre $minTerm y $maxTerm';
            }
            return null;
          },
        ),
      ],
    );
  }
}
