import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDateInputField extends StatefulWidget {
  final List<String> hints;
  final List<TextEditingController> controllers;
  final double boxWidth;
  final double boxHeight;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final Color? backgroundColor;
  final Function(String)? onChange;

  CustomDateInputField({
    required this.hints,
    required this.controllers,
    this.boxWidth = 10.0,
    this.boxHeight = 10.0,
    this.textStyle,
    this.inputDecoration,
    this.spacing = 10.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.backgroundColor,
    this.onChange,
  });

  @override
  _CustomDateInputFieldState createState() => _CustomDateInputFieldState();
}

class _CustomDateInputFieldState extends State<CustomDateInputField> {
  final List<FocusNode> _focusNodes = List.generate(8, (_) => FocusNode());

  @override
  void dispose() {
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        _buildDateBox(0),
        _buildDateBox(1),
        SizedBox(width: widget.spacing),
        _buildDateBox(2),
        _buildDateBox(3),
        SizedBox(width: widget.spacing),
        _buildDateBox(4),
        _buildDateBox(5),
        _buildDateBox(6),
        _buildDateBox(7),
      ],
    );
  }

  Widget _buildDateBox(int index) {
    return RawKeyboardListener(
      focusNode: FocusNode(), // Needed to detect keyboard events
      onKey: (event) {
        if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
          if (widget.controllers[index].text.isEmpty && index > 0) {
            // Clear the previous field's text and move focus to it
            widget.controllers[index - 1].clear();
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(2.0),
        width: widget.boxWidth,
        height: widget.boxHeight,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(
            // color: Color(0xFFA7713F),
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          controller: widget.controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.center,
          maxLength: 1,
          onChanged: (value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
            if (value.length == 1 && index < _focusNodes.length - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
          },
          style: widget.textStyle ?? TextStyle(fontSize: 13, color: Colors.white),
          decoration: widget.inputDecoration?.copyWith(
            counterText: '',
            hintText: widget.hints[index],
            hintStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ) ??
              InputDecoration(
                counterText: '',
                hintText: widget.hints[index],
                border: OutlineInputBorder(),
              ),
        ),
      ),
    );
  }
}
