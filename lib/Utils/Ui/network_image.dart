import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatefulWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ImageNetworkWidget({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  @override
  State<ImageNetworkWidget> createState() => _ImageNetworkWidgetState();
}

class _ImageNetworkWidgetState extends State<ImageNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.image,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
    );
  }
}
