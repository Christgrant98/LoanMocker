import 'package:flutter/material.dart';

import 'package:cw_bank_credit/presentation/widgets/utils/base_text_form_field.dart';

import 'text_view.dart';

// todo: check how to show money format
class BaseSalaryFormField extends StatelessWidget {
  final void Function(String?, bool) onValueChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const BaseSalaryFormField({
    Key? key,
    required this.onValueChange,
    this.initialValue,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
            text: 'Cuanto es tu salario  base?',
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        BaseTextFormField(
          keyboardType: TextInputType.number,
          initialValue: initialValue,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: Colors.white,
            helperStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
              fontFamily: 'ProductSans',
            ),
            helperText:
                'Digita tu salario para calcular el prestamo que necesitas',
            hintText: '\$10\'000.000,00',
            hintStyle: TextStyle(
                fontFamily: 'ProductSans',
                color: Color.fromARGB(255, 190, 190, 190),
                fontSize: 12),
          ),
          onChanged: onValueChange,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
