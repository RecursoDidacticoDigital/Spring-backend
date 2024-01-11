import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({required this.imageUrl, this.key}): super(key: key);

  final String imageUrl;
  final Key? key;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.imageUrl,
      width: 200.0
    );
  }
}