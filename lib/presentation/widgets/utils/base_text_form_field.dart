// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextFormField extends StatefulWidget {
  final void Function(String?, bool)? onChanged;
  final void Function(int?, bool)? onValueChange;
  final void Function(double?, bool)? onDoubleValueChange;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final int maxLines;
  final int? minLines;
  final String? initialValue;
  final bool obscureText;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;
  final TextEditingController? controller;
  final int? maxLength;
  final TextAlign textAlign;
  final Widget? widget;

  const BaseTextFormField({
    Key? key,
    this.onChanged,
    this.onValueChange,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
    this.initialValue,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.enabled = true,
    this.controller,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.widget,
    this.onDoubleValueChange,
  }) : super(key: key);

  @override
  State<BaseTextFormField> createState() => _BaseTextFormField();
}

class _BaseTextFormField extends State<BaseTextFormField> {
  late final TextEditingController _controller;
  bool _touched = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? '';
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration defaultDecoration = _buildDefaultDecoration();
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'ProductSans',
      ),
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: widget.decoration == null
          ? defaultDecoration
          : widget.decoration!.copyWith(
              border: widget.decoration?.border ?? defaultDecoration.border,
              enabledBorder: widget.decoration?.enabledBorder ??
                  defaultDecoration.enabledBorder,
              focusedBorder: widget.decoration?.focusedBorder ??
                  defaultDecoration.focusedBorder,
              errorBorder: widget.decoration?.errorBorder ??
                  defaultDecoration.errorBorder,
              focusedErrorBorder: widget.decoration?.focusedErrorBorder ??
                  defaultDecoration.focusedErrorBorder,
              errorText: _validator(_controller.text),
            ),
      validator: _validator,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }

  void _onChanged() {
    setState(() {
      _touched = true;
      String value = _controller.text;
      if (widget.onChanged != null) widget.onChanged!(value, _isValid());
    });
  }

  bool _isValid() => null == _validator(_controller.text);

  String? _validator(String? value) {
    if (!_touched) return null;
    if (widget.validator == null) {
      return null;
    } else {
      return widget.validator!(value);
    }
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
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder,
      errorBorder: defaultBorder,
      focusedErrorBorder: defaultBorder,
      errorText: _validator(_controller.text),
    );
  }
}
