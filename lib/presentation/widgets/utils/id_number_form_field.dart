import 'package:flutter/material.dart';

import 'text_view.dart';
import 'base_text_form_field.dart';

class IdNumberFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const IdNumberFormField({
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
        const TextView(
            text: 'Identificación',
            color: Colors.grey,
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
              hintText: 'Escribe tu número de identificación',
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 190, 190, 190),
                fontSize: 12,
                fontFamily: 'ProductSans',
              ),
            ),
            onChanged: onChange,
            onFieldSubmitted: onFieldSubmitted,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su número de identificación';
              }
              final RegExp idNumber = RegExp(r'^\d{10}$');
              if (!idNumber.hasMatch(value)) {
                return 'Ingrese un número de identificación valido';
              }
              return null;
            }),
      ],
    );
  }
}
