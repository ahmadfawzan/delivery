import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<DropdownMenuItem> items;
  final ValueChanged? onChanged;
  final Icon? icon;
  final Visibility? iconVisibility;
  final dynamic value;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Text? hint;
  final Function()? onTap;
  int elevation;
  bool isExpanded;
  double iconSize;
  final TextStyle? style;
  bool isDense;
  final Color? dropdownColor;
  final Widget? underline;
  DropdownButtonWidget({
    Key? key,
    required this.items,
    this.onChanged,
    this.icon,
    this.value,
    this.selectedItemBuilder,
    this.hint,
    this.onTap,
    this.style,
    this.iconSize=24.0,
    this.elevation=8,
    this.isDense=false,
    this.isExpanded=false,
    this.dropdownColor, this.underline, this.iconVisibility,
  }) : super(key: key);

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: widget.items,
      onChanged: widget.onChanged,
      icon: widget.icon ?? widget.iconVisibility,
      value: widget.value,
      selectedItemBuilder: widget.selectedItemBuilder,
      hint: widget.hint,
      onTap: widget.onTap,
      elevation: widget.elevation,
      isExpanded: widget.isExpanded,
      iconSize: widget.iconSize,
      style: widget.style,
      isDense: widget.isDense,
      dropdownColor: widget.dropdownColor,
      underline: widget.underline,
    );
  }
}
