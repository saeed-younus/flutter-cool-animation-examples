import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomRawImage extends StatelessWidget {
  final ui.Image image;

  const CustomRawImage({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: image,
      fit: BoxFit.cover,
      scale: 1,
    );
  }
}
