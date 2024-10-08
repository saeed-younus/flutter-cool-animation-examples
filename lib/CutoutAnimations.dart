import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum Cutouts {
  centerVertical,
  centerHorizontal,
  topRightBottomLeft,
  topLeftBottomRight,
}

class TextCutoutAnimtaion extends StatefulWidget {
  final String text;
  final Function() onExitAnimation;
  const TextCutoutAnimtaion({
    required this.text,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<TextCutoutAnimtaion> createState() => _TextCutoutAnimtaionState();
}

class _TextCutoutAnimtaionState extends State<TextCutoutAnimtaion> {
  late double textWidth = min(
    widget.text.length * 32,
    MediaQuery.sizeOf(context).width - 32,
  );
  final double textHeight = 48;

  final Random _random = Random();

  late final int _randomIndex = _random.nextInt(Cutouts.values.length);

  late final Cutouts cutoutValue = Cutouts.values[_randomIndex];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: textHeight,
        width: textWidth,
        child: FittedBox(
          fit: BoxFit.fill,
          child: CutoutAnimator(
            cutoutValue: cutoutValue,
            widget: Text(
              widget.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    height: 0.77,
                    letterSpacing: -2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ).animate(
            delay: const Duration(milliseconds: 1800),
            onComplete: (controller) {
              widget.onExitAnimation();
            },
          ),
        ),
      ),
    );
  }
}

class CutoutAnimtaionForChecking extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;
  final Function() onExitAnimation;
  const CutoutAnimtaionForChecking({
    required this.child,
    required this.height,
    required this.width,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<CutoutAnimtaionForChecking> createState() =>
      _CutoutAnimtaionForCheckingState();
}

class _CutoutAnimtaionForCheckingState
    extends State<CutoutAnimtaionForChecking> {
  final Random _random = Random();

  late final int _randomIndex = _random.nextInt(Cutouts.values.length);

  late final Cutouts cutoutValue = Cutouts.values[_randomIndex];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: FittedBox(
          fit: BoxFit.fill,
          child: CutoutAnimator(
            cutoutValue: cutoutValue,
            widget: widget.child,
          ).animate(
            delay: const Duration(milliseconds: 1800),
            onComplete: (controller) {
              widget.onExitAnimation();
            },
          ),
        ),
      ),
    );
  }
}

class WidgetCutoutAnimtaion extends StatefulWidget {
  final Widget child;
  final int delayInMilli;
  final int durationInMilli;
  final bool forward;
  final Function() onExitAnimation;
  const WidgetCutoutAnimtaion({
    required this.child,
    required this.delayInMilli,
    required this.durationInMilli,
    required this.forward,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<WidgetCutoutAnimtaion> createState() => _WidgetCutoutAnimtaionState();
}

class _WidgetCutoutAnimtaionState extends State<WidgetCutoutAnimtaion> {
  final Random _random = Random();

  late final int _randomIndex = _random.nextInt(Cutouts.values.length);

  late final Cutouts cutoutValue = Cutouts.values[_randomIndex];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CutoutAnimator(
        cutoutValue: cutoutValue,
        widget: widget.child,
        forward: widget.forward,
        durationInMilli: widget.durationInMilli,
        delayInMilli: widget.delayInMilli,
      ).animate(
        delay: Duration(
          milliseconds: widget.delayInMilli + widget.durationInMilli,
        ),
        onComplete: (controller) {
          widget.onExitAnimation();
        },
      ),
    );
  }
}

class CutoutAnimator extends StatelessWidget {
  final Cutouts cutoutValue;
  final Widget widget;
  final bool forward;
  final int delayInMilli;
  final int durationInMilli;
  const CutoutAnimator({
    required this.cutoutValue,
    required this.widget,
    this.forward = true,
    this.delayInMilli = 400,
    this.durationInMilli = 400,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (cutoutValue) {
      case Cutouts.centerVertical:
        return Stack(
          children: [
            ClipPath(
              clipper: HalfLeftRectangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slideY(
                  begin: forward ? -10 : 0,
                  end: forward ? 0 : -10,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slideY(
                  begin: 0,
                  end: -2,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
            ClipPath(
              clipper: HalfRightRectangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slideY(
                  begin: forward ? 10 : 0,
                  end: forward ? 0 : 10,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slideY(
                  begin: 0,
                  end: 2,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
          ],
        );
      case Cutouts.centerHorizontal:
        return Stack(
          children: [
            ClipPath(
              clipper: HalfTopRectangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slideX(
                  begin: forward ? -5 : 0,
                  end: forward ? 0 : -5,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slideX(
                  begin: 0,
                  end: -2,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
            ClipPath(
              clipper: HalfBottomRectangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slideX(
                  begin: forward ? 5 : 0,
                  end: forward ? 0 : 5,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slideX(
                  begin: 0,
                  end: 2,
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
          ],
        );
      case Cutouts.topRightBottomLeft:
        return Stack(
          children: [
            ClipPath(
              clipper: LeftTopTriangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slide(
                  begin: forward ? const Offset(5, -5) : Offset.zero,
                  end: forward ? Offset.zero : const Offset(5, -5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slide(
                  begin: Offset.zero,
                  end: const Offset(5, -5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
            ClipPath(
              clipper: RightBottomTriangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slide(
                  begin: forward ? const Offset(-5, 5) : Offset.zero,
                  end: forward ? Offset.zero : const Offset(-5, 5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slide(
                  begin: Offset.zero,
                  end: const Offset(-5, 5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
          ],
        );
      case Cutouts.topLeftBottomRight:
        return Stack(
          children: [
            ClipPath(
              clipper: RightTopTriangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slide(
                  begin: forward ? const Offset(-5, -5) : Offset.zero,
                  end: forward ? Offset.zero : const Offset(-5, -5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slide(
                  begin: Offset.zero,
                  end: const Offset(-5, -5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
            ClipPath(
              clipper: LeftBottomTriangle(),
              child: widget,
            )
                .animate(
                  delay: Duration(milliseconds: delayInMilli),
                )
                .slide(
                  begin: forward ? const Offset(5, 5) : Offset.zero,
                  end: forward ? Offset.zero : const Offset(5, 5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: Duration(milliseconds: durationInMilli),
                )
                .then(delay: const Duration(milliseconds: 600))
                .slide(
                  begin: Offset.zero,
                  end: const Offset(5, 5),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                  duration: const Duration(milliseconds: 600),
                )
                .fade(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}

class HalfLeftRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width / 2, size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HalfRightRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(size.width / 2, 0),
          Offset(size.width, size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HalfBottomRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, size.height / 2),
          Offset(size.width, size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HalfTopRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, 0),
          Offset(size.width, size.height / 2),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LeftBottomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RightTopTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LeftTopTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RightBottomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
