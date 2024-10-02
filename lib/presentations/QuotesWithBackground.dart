import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class QuotesWithBackground extends StatefulWidget {
  final ui.Image bgImage;
  final VoidCallback onExitAnimation;
  final String quote;

  const QuotesWithBackground({
    required this.onExitAnimation,
    required this.quote,
    required this.bgImage,
    super.key,
  });

  @override
  State<QuotesWithBackground> createState() => _QuotesWithBackgroundState();
}

class _QuotesWithBackgroundState extends State<QuotesWithBackground> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
