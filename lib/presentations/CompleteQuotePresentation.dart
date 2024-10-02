import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/presentations/QuotesWithBackground.dart';
import 'dart:ui' as ui;

import 'package:flutter_animation_practice/presentations/QuotesWithoutBackground.dart';

class CompleteQuotePresentaition extends StatefulWidget {
  final ui.Image? bgImage;
  final String quote;
  final VoidCallback onExitAnimation;

  const CompleteQuotePresentaition({
    required this.bgImage,
    required this.quote,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<CompleteQuotePresentaition> createState() =>
      _CompleteQuotePresentaitionState();
}

class _CompleteQuotePresentaitionState
    extends State<CompleteQuotePresentaition> {
  @override
  Widget build(BuildContext context) {
    return widget.bgImage == null
        ? QuotesWithoutBackground(
            onExitAnimation: widget.onExitAnimation,
            quote: widget.quote,
          )
        : QuotesWithBackground(
            onExitAnimation: widget.onExitAnimation,
            quote: widget.quote,
            bgImage: widget.bgImage!,
          );
  }
}
