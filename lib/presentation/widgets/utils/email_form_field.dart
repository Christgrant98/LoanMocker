import 'package:flutter/material.dart';

import 'text_view.dart';
import 'base_text_form_field.dart';

class EmailFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const EmailFormField({
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
            text: 'Email',
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
            hintText: 'Uname@mail.com',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 190, 190, 190),
              fontSize: 12,
              fontFamily: 'ProductSans',
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su Email';
            }
            final emailRegex = RegExp(r'^[\w-zñ\.]+@([\w-zñ]+\.)+[\w-z]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Ingrese un email válido';
            }
            return null;
          },
          onChanged: (String? value, bool isValid) {
            onChange(value?.toLowerCase(), isValid);
          },
        ),
      ],
    );
  }
}
