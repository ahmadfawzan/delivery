import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ImageWidget({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(widget.image),
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
    );
  }
}
