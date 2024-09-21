import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionInputField extends StatefulWidget {
  final String? hint;
  final String? label;
  final bool? isPasswordField;
  final TextStyle? textStyle;
  final Function(String? value)? onChange;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final Key? key;
  final FocusNode? focusNode;
  final Future<String?> Function(String?)? asyncValidator;

  DescriptionInputField({
    this.hint,
    this.isPasswordField,
    this.onChange,
    this.keyboardType,
    this.controller,
    this.maxLines,
    this.label,
    this.textStyle,
    this.margin,
    this.height,
    this.key,
    this.focusNode,
    this.asyncValidator,
  }) : super(key: key);

  @override
  _DescriptionInputFieldState createState() => _DescriptionInputFieldState();
}

class _DescriptionInputFieldState extends State<DescriptionInputField> {
  late bool _isHidden;
  late String text;
  late bool isPasswordField;
  int currentLength = 0;

  @override
  void initState() {
    super.initState();
    isPasswordField = widget.isPasswordField ?? false;
    _isHidden = isPasswordField;
    text = widget.controller?.text ?? '';
    currentLength = text.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 6),
      height: widget.height ?? 50,
      child: TextFormField(
        key: widget.key,
        onChanged: (value) {
          setState(() {
            text = value;
            currentLength = value.length;
          });
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        style: widget.textStyle ?? TextStyle(fontSize: 13, color: Colors.black),
        obscureText: _isHidden,
        maxLines: widget.maxLines ?? 1,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
          border: OutlineInputBorder(),
          suffixIcon: isPasswordField
              ? IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
            icon: Icon(
              _isHidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          )
              : null,
          counterText: '${currentLength.toString()} /180',
        ),
        validator: (value) {
          if (widget.asyncValidator != null) {
            // Handle async validation if provided
            // You can implement async validation logic here
          }
          return null; // Return null if no validation error
        },
      ),
    );
  }
}
