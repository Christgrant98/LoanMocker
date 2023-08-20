import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'text_view.dart';

class CreditTypeFormField extends StatefulWidget {
  final void Function(String?) onChange;
  final List<String> creditTypes;

  const CreditTypeFormField({
    super.key,
    required this.creditTypes,
    required this.onChange,
  });

  @override
  State<CreditTypeFormField> createState() => _CreditTypeFormFieldState();
}

class _CreditTypeFormFieldState extends State<CreditTypeFormField> {
  String? selectedCreditType;

  @override
  Widget build(BuildContext context) {
    InputDecoration defaultDecoration = _buildDefaultDecoration();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
          text: 'Que tipo de credito deseas realizar?',
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField(
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Color.fromARGB(255, 218, 218, 218),
          ),
          borderRadius: BorderRadius.circular(10),
          decoration: defaultDecoration,
          value: selectedCreditType,
          hint: const TextView(
            text: 'Selecciona el tipo de credito',
            color: Color.fromARGB(255, 190, 190, 190),
            fontSize: 12,
          ),
          onChanged: (newValue) {
            setState(() {
              selectedCreditType = newValue;
              widget.onChange(newValue);
            });
          },
          items: widget.creditTypes.map((String creditType) {
            return DropdownMenuItem(
              value: creditType,
              child: TextView(
                text: creditType,
                fontSize: 12,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  InputDecoration _buildDefaultDecoration() {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0.8,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );

    return InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      filled: true,
      fillColor: Colors.white,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder,
      focusedErrorBorder: defaultBorder,
    );
  }
}
