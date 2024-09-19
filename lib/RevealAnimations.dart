import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum Reveals {
  topToBottom,
  bottomToTop,
  centerHorizontal,
  centerVertical,
  sideHorizontal,
  sideVertical,
  centerCircular,
  topLeftCircular,
  topRightCircular,
  bottomLeftCircular,
  bottomRightCircular,
}

class TextRevealAnimtaion extends StatefulWidget {
  final String text;
  final Function() onExitAnimation;
  const TextRevealAnimtaion({
    required this.text,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<TextRevealAnimtaion> createState() => _TextRevealAnimtaionState();
}

class _TextRevealAnimtaionState extends State<TextRevealAnimtaion> {
  late double textWidth = min(
    widget.text.length * 32,
    MediaQuery.sizeOf(context).width - 32,
  );
  final double textHeight = 48;

  final Random _random = Random();

  late final int _randomIndex = _random.nextInt(Reveals.values.length);

  late final Reveals revealValue = Reveals.values[_randomIndex];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ),
          duration: const Duration(milliseconds: 800),
          curve: Curves.ease,
          builder: (context, value, child) {
            return RevealAnimator(
              animationValue: value,
              revealValue: revealValue,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: textHeight,
                  width: textWidth,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      widget.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            height: 0.77,
                            letterSpacing: -2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
            .animate(
              delay: const Duration(milliseconds: 1200),
              onComplete: (controller) {
                widget.onExitAnimation();
              },
            )
            .slideX(
              begin: 0,
              end: 5,
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
            )
            .blurX(
              begin: 0,
              end: 10,
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
            ),
      ),
    );
  }
}

class WidgetRevealAnimtaion extends StatefulWidget {
  final Widget child;
  final int delayInMilli;
  final int durationInMilli;
  final bool forward;
  final Function() onExitAnimation;
  const WidgetRevealAnimtaion({
    required this.child,
    required this.delayInMilli,
    required this.durationInMilli,
    required this.forward,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<WidgetRevealAnimtaion> createState() => _WidgetRevealAnimtaionState();
}

class _WidgetRevealAnimtaionState extends State<WidgetRevealAnimtaion> {
  final Random _random = Random();

  late final int _randomIndex = _random.nextInt(Reveals.values.length);

  late final Reveals revealValue = Reveals.values[_randomIndex];

  late bool delayDone = widget.delayInMilli == 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: !delayDone
            ? TweenAnimationBuilder(
                /// this tween implementation for delay
                tween: Tween<double>(
                  begin: 0,
                  end: 1,
                ),
                duration: Duration(milliseconds: widget.delayInMilli),
                onEnd: () {
                  setState(() {
                    delayDone = true;
                  });
                },
                builder: (context, value, child) {
                  return RevealAnimator(
                    animationValue: widget.forward ? 0 : 1,
                    revealValue: revealValue,
                    child: widget.child,
                  );
                },
              )
            : TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: widget.forward ? 0 : 1,
                  end: widget.forward ? 1 : 0,
                ),
                duration: Duration(milliseconds: widget.durationInMilli),
                curve: Curves.ease,
                builder: (context, value, child) {
                  return RevealAnimator(
                    animationValue: value,
                    revealValue: revealValue,
                    child: widget.child,
                  );
                },
              ).animate(
                delay: Duration(
                  milliseconds: widget.delayInMilli + widget.durationInMilli,
                ),
                onComplete: (controller) {
                  widget.onExitAnimation();
                },
              )
        // .slideX(
        //   begin: 0,
        //   end: 5,
        //   duration: const Duration(milliseconds: 600),
        //   curve: Curves.ease,
        // )
        // .blurX(
        //   begin: 0,
        //   end: 10,
        //   duration: const Duration(milliseconds: 600),
        //   curve: Curves.ease,
        // ),
        );
  }
}

class RevealAnimator extends StatelessWidget {
  final double animationValue;
  final Reveals revealValue;
  final Widget child;
  const RevealAnimator({
    required this.animationValue,
    required this.revealValue,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (revealValue) {
      case Reveals.topToBottom:
        return ClipPath(
          clipper: TopToBottomRevealClipper(animationValue),
          child: child,
        );
      case Reveals.bottomToTop:
        return ClipPath(
          clipper: BottomToTopRevealClipper(animationValue),
          child: child,
        );
      case Reveals.centerHorizontal:
        return ClipPath(
          clipper: CenterHorizontalRevealClipper(animationValue),
          child: child,
        );
      case Reveals.centerVertical:
        return ClipPath(
          clipper: CenterVerticalRevealClipper(animationValue),
          child: child,
        );
      case Reveals.sideHorizontal:
        return ClipPath(
          clipper: SideHorizontalRevealClipper(animationValue),
          child: child,
        );
      case Reveals.sideVertical:
        return ClipPath(
          clipper: SideVerticalRevealClipper(animationValue),
          child: child,
        );
      case Reveals.centerCircular:
        return ClipPath(
          clipper: SideHorizontalRevealClipper(animationValue),
          // clipper: CenterCircularRevealClipper(animationValue),
          child: child,
        );
      case Reveals.topLeftCircular:
        return ClipPath(
          clipper: SideHorizontalRevealClipper(animationValue),
          // clipper:
          //     CenterCircularRevealClipper(animationValue, const Offset(-1, -1)),
          child: child,
        );
      case Reveals.topRightCircular:
        return ClipPath(
          clipper: CenterVerticalRevealClipper(animationValue),
          // clipper:
          //     CenterCircularRevealClipper(animationValue, const Offset(1, -1)),
          child: child,
        );
      case Reveals.bottomLeftCircular:
        return ClipPath(
          clipper: CenterVerticalRevealClipper(animationValue),
          // clipper:
          //     CenterCircularRevealClipper(animationValue, const Offset(-1, 1)),
          child: child,
        );
      case Reveals.bottomRightCircular:
        return ClipPath(
          clipper: CenterVerticalRevealClipper(animationValue),
          // clipper:
          //     CenterCircularRevealClipper(animationValue, const Offset(1, 1)),
          child: child,
        );
    }
  }
}

class TopToBottomRevealClipper extends CustomClipper<Path> {
  final double value;
  TopToBottomRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width, size.height * value),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BottomToTopRevealClipper extends CustomClipper<Path> {
  final double value;
  BottomToTopRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width * value, size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DiagonalRevealClipper extends CustomClipper<Path> {
  final double value;
  DiagonalRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width * value, size.height * value),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CenterVerticalRevealClipper extends CustomClipper<Path> {
  final double value;
  CenterVerticalRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, (size.height / 2) - (size.height / 2 * value)),
          Offset(size.width, (size.height / 2) + (size.height / 2 * value)),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CenterHorizontalRevealClipper extends CustomClipper<Path> {
  final double value;
  CenterHorizontalRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(size.width / 2 - (size.width / 2 * value), 0),
          Offset(size.width / 2 + (size.width / 2 * value), size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SideHorizontalRevealClipper extends CustomClipper<Path> {
  final double value;
  SideHorizontalRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width / 2 * value, size.height),
        ),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(size.width - (size.width / 2 * value), 0),
          Offset(size.width, size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SideVerticalRevealClipper extends CustomClipper<Path> {
  final double value;
  SideVerticalRevealClipper(this.value);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width, size.height / 2 * value),
        ),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(0, size.height - (size.height / 2 * value)),
          Offset(size.width, size.height),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CenterCircularRevealClipper extends CustomClipper<Path> {
  final double value;
  final Offset? center;
  CenterCircularRevealClipper(this.value, [this.center]);

  @override
  Path getClip(Size size) {
    final multiple = center == null
        ? 0.65
        : center!.dx == 0 && center!.dy == 0
            ? 0.65
            : 1.15;
    final double radius = (size.width > size.height ? size.width : size.height);
    Path path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(
            (size.width / 2) + (size.width / 2 * (center?.dx ?? 0)),
            (size.height / 2) + (size.height / 2 * (center?.dy ?? 0)),
          ),
          radius: radius * value,
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
