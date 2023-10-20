import 'dart:ui';

import 'package:flutter/material.dart';

class TextWidgets extends StatefulWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextOverflow? textOverFlow;
  final TextAlign? textAlign;

  const TextWidgets( {
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textDecoration,
    this.textOverFlow,
    this.textAlign,
  }) : super(key: key);

  @override
  State<TextWidgets> createState() => _TextWidgetsState();
}

class _TextWidgetsState extends State<TextWidgets> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.color,
          decoration: widget.textDecoration

      ),
      overflow: widget.textOverFlow,
      textAlign: widget.textAlign,
    );
  }
}
