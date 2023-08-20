import 'package:flutter/material.dart';

import 'text_view.dart';
import 'base_text_form_field.dart';

class NameFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const NameFormField({
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
            text: 'Nombre completo',
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        BaseTextFormField(
            initialValue: initialValue,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(
                Icons.person_outlined,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Escribe tu nombre',
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
                return 'Ingrese su nombre';
              }
              final nameRegExp = RegExp(
                  r"^\s*([A-Za-z][A-Za-zñÑ]*(?:\s+[A-Za-z][A-Za-zñÑ]*)*\.?\s*)$");
              if (!nameRegExp.hasMatch(value)) {
                return 'Ingrese un nombre valido';
              }
              return null;
            }),
      ],
    );
  }
}
