import 'package:flutter/material.dart';

import 'text_view.dart';

import 'package:flutter/material.dart';

class CreditTypeFormField extends StatefulWidget {
  final void Function(String?, double?) onChange;
  final List<String> creditTypes;
  final Map<String, double> creditRates;

  const CreditTypeFormField({
    Key? key,
    required this.creditTypes,
    required this.onChange,
    required this.creditRates,
  }) : super(key: key);

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
          text: 'What type of credit do you want to apply for?',
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
            text: 'Select the credit type',
            color: Color.fromARGB(255, 190, 190, 190),
            fontSize: 12,
          ),
          onChanged: (newValue) {
            setState(() {
              selectedCreditType = newValue;
              double? selectedRate = widget.creditRates[newValue];
              widget.onChange(newValue, selectedRate);
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
