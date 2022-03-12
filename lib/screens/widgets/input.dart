import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
    this.controller,
    this.textAlign = TextAlign.start,
    this.inputDecoration,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.style,
    this.hintText,
    this.hintStyle,
    this.label,
    this.labelStyle,
    this.textInputAction,
    this.focusNode,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.expands =false,
    this.autoFocus = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.focusedBorder
  }) : super(key: key);

  final TextEditingController controller;
  final TextAlign textAlign;
  final InputDecoration inputDecoration;
  final bool obscureText;
  final bool readOnly;
  final GestureTapCallback onTap;
  final double width;
  final double height;
  final EdgeInsets margin;
  final TextStyle style;
  final String hintText;
  final TextStyle hintStyle;
  final String label;
  final TextStyle labelStyle;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final bool expands;
  final bool autoFocus;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final InputBorder focusedBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign,
      decoration: inputDecoration ?? InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: focusedBorder,
        hintText: hintText
      ),
      obscureText: obscureText,
      readOnly: readOnly,
      textInputAction: textInputAction,
      onTap: onTap,
      style: style,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      autofocus: autoFocus,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }
}
