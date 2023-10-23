import 'package:flutter/material.dart';

class TextFormFieldWidgets extends StatefulWidget {
  final String hintText;
  final Icon? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final IconButton? suffixIcon;
  final Function()? onTap;
  bool readOnly;
  bool enableSuggestions;
  bool passwordVisible;
  bool alignLabelWithHint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  bool autocorrect;
  final String? labeltext;
  final TextStyle? labelstyle;
  final TextStyle? hintstyle;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final UnderlineInputBorder? enabledBorderUnderline;
  final UnderlineInputBorder? focusedBorderUnderline;
  final InputBorder? inputBorder;

  TextFormFieldWidgets({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.passwordVisible = false,
    this.labeltext,
    this.alignLabelWithHint = true,
    this.labelstyle,
    this.hintstyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.enabledBorderUnderline,
    this.focusedBorderUnderline,
    this.inputBorder,
    this.contentPadding,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextFormFieldWidgets> createState() => _TextFormFieldWidgetsState();
}

class _TextFormFieldWidgetsState extends State<TextFormFieldWidgets> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      obscureText: widget.passwordVisible,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        alignLabelWithHint: widget.alignLabelWithHint,
        border: widget.inputBorder,
        contentPadding: widget.contentPadding,
        enabledBorder: widget.enabledBorder ?? widget.enabledBorderUnderline,
        focusedBorder: widget.focusedBorder ?? widget.focusedBorderUnderline,
        errorBorder: widget.errorBorder,
        focusedErrorBorder: widget.focusedErrorBorder,
        hintText: widget.hintText,
        labelText: widget.labeltext,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: widget.labelstyle,
        hintStyle: widget.hintstyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
