import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/material.dart';

class MaterialButtonWidgets extends StatefulWidget {
  final Function()? onPressed;
  final double? height;
  final double? minWidth;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  final ShapeBorder? shape;

  const MaterialButtonWidgets({
    Key? key,
    this.onPressed,
    this.height,
    this.minWidth,
    this.color,
    this.child,
    this.textColor,
    this.shape,
  }) : super(key: key);

  @override
  State<MaterialButtonWidgets> createState() => _MaterialButtonWidgetsState();
}

class _MaterialButtonWidgetsState extends State<MaterialButtonWidgets> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      height: widget.height,
      minWidth: widget.minWidth,
      textColor: widget.textColor,
      color: widget.color,
      shape: widget.shape,
      child: widget.child,
    );
  }
}
