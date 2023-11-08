import 'package:flutter/material.dart';

import 'text_view.dart';
import 'base_text_form_field.dart';

class PasswordFormField extends StatefulWidget {
  final void Function(String? value, bool valid) onChange;
  final Function? additionalValidator;
  final String? emptyMessage;
  final String? labelText;
  final void Function(String)? onFieldSubmitted;

  const PasswordFormField({
    Key? key,
    required this.onChange,
    this.additionalValidator,
    this.emptyMessage,
    this.labelText,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  PasswordFormFieldState createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
            text: 'Contraseña',
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        BaseTextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: InkWell(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                  color: Colors.grey,
                  obscureText
                      ? Icons.lock_outline_rounded
                      : Icons.lock_open_rounded),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: 'Password',
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 190, 190, 190),
              fontSize: 12,
              fontFamily: 'ProductSans',
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          obscureText: obscureText,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su contraseña';
            }
            if (widget.additionalValidator != null) {
              return widget.additionalValidator!(value);
            }
            return null;
          },
          onChanged: (String? value, bool valid) {
            widget.onChange(value, valid);
          },
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
