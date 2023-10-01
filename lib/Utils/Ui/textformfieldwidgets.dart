import 'package:flutter/material.dart';
class TextFormFieldWidgets extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final double borderRudiucCircularSize;
  final IconButton? suffixIcon;
  final Function()? onTap;
  bool readOnly;
  bool enableSuggestions;
  bool passwordVisible;
  bool alignLabelWithHint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  bool autocorrect;
  final String? labelText;



  TextFormFieldWidgets({Key? key,
  required this.hintText,
  required this.prefixIcon,
  this.controller,
  this.suffixIcon,
  this.validator,
  this.onTap,
  this.readOnly=false,
  this.autocorrect=false,
  this.enableSuggestions=false,
  this.passwordVisible=false,
  this.labelText,
  this.alignLabelWithHint=true,
  this.borderRudiucCircularSize=0,

  }) : super(key: key);

  @override
  State<TextFormFieldWidgets> createState() => _TextFormFieldWidgetsState();
}

class _TextFormFieldWidgetsState extends State<TextFormFieldWidgets> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      enableSuggestions:widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      obscureText: widget.passwordVisible,
      controller: widget.controller,
      validator: widget.validator,
      style: const TextStyle(
        fontSize: 16.0,
      ),
      decoration:   InputDecoration(
        alignLabelWithHint: widget.alignLabelWithHint,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRudiucCircularSize),
          borderSide: const BorderSide(color: Color(0xffBFBFBF)),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRudiucCircularSize),
          borderSide: const BorderSide(color: Color(0xffBFBFBF)),
        ),
        hintText:widget.hintText,
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(color: Color(0xff9B9B9B)),
        hintStyle: const TextStyle(color: Color(0xff9B9B9B) ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),

    );;
  }
}






