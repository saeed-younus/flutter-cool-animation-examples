import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui' as ui;

enum AnimAxis {
  X,
  Y;
}

class ImageParallaxEffectAnimation extends StatefulWidget {
  final AnimAxis inAxis;
  final AnimAxis outAxis;
  // final String bgImage;
  final ui.Image bgImage;
  final Function() onExitAnimation;

  const ImageParallaxEffectAnimation({
    required this.bgImage,
    required this.inAxis,
    required this.outAxis,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<ImageParallaxEffectAnimation> createState() =>
      _ImageParallaxEffectAnimationState();
}

class _ImageParallaxEffectAnimationState
    extends State<ImageParallaxEffectAnimation> {
  final Random _random = Random();

  final List<CustomClipper<Path>> _customClippers = [];

  @override
  void initState() {
    super.initState();

    if (_random.nextInt(2) == 0) {
      _customClippers.add(CenterDiamond());
      _customClippers.add(TriangleRectangle());
    } else {
      _customClippers.add(CenterRectangle());
      if (_random.nextInt(2) == 0) {
        _customClippers.add(BottomLefttRectangle());
      } else {
        _customClippers.add(BottomRightRectangle());
      }
    }

    Future.delayed(
      const Duration(milliseconds: 2600),
      () {
        widget.onExitAnimation();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          // child: Image.asset(
          //   widget.bgImage,
          //   fit: BoxFit.cover,
          //   scale: 1.2,
          // )
          child: RawImage(
            image: widget.bgImage,
            fit: BoxFit.cover,
            scale: 1.2,
          )
              .animate()
              .slide(
                begin: Offset(
                  widget.inAxis == AnimAxis.X ? 0.07 : 0,
                  widget.inAxis == AnimAxis.Y ? 0.03 : 0,
                ),
                end: Offset.zero,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1200),
              )
              .then(delay: const Duration(milliseconds: 1400))
              .slide(
                begin: Offset.zero,
                end: Offset.zero,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 600),
              ),
        ),
        SizedBox.expand(
          child: ClipPath(
            clipper: _customClippers[0],
            // child: Image.asset(
            //   widget.bgImage,
            //   fit: BoxFit.cover,
            //   scale: 1.2,
            // )
            child: RawImage(
              image: widget.bgImage,
              fit: BoxFit.cover,
              scale: 1.2,
            )
                .animate()
                .scaleXY(
                  begin: 1.1,
                  end: 1,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1400),
                )
                .slide(
                  begin: Offset(
                    widget.inAxis == AnimAxis.X ? 0.15 : 0,
                    widget.inAxis == AnimAxis.Y ? 0.1 : 0,
                  ),
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1400),
                )
                .then(delay: const Duration(milliseconds: 1200))
                .slide(
                  begin: Offset.zero,
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 600),
                ),
          ),
        ),
        SizedBox.expand(
          child: ClipPath(
            clipper: _customClippers[1],
            child: RawImage(
              image: widget.bgImage,
              fit: BoxFit.cover,
              scale: 1.2,
            )
                // child: Image.asset(
                //   widget.bgImage,
                //   fit: BoxFit.cover,
                //   scale: 1.2,
                // )
                .animate()
                .slide(
                  begin: Offset(
                    widget.inAxis == AnimAxis.X ? 0.12 : -0.05,
                    widget.inAxis == AnimAxis.Y ? 0.1 : 0.02,
                  ),
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1600),
                )
                .then(delay: const Duration(milliseconds: 1000))
                .slide(
                  begin: Offset.zero,
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 600),
                ),
          ),
        ),
        Container(
          color: const Color(0x11000000),
          width: double.infinity,
          height: double.infinity,
          child: const SizedBox(),
        ),
        Center(
          child: SizedBox(
            height: 48,
            width: 200,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                "QUICK",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  height: 0.77,
                  letterSpacing: -2,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    const BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(0, 4),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
              .animate()
              .fade(
                begin: 0.3,
                end: 1,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1200),
              )
              .slide(
                begin: Offset(
                  widget.inAxis == AnimAxis.X ? 0.5 : 0,
                  widget.inAxis == AnimAxis.Y ? 2 : 0,
                ),
                end: Offset.zero,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1200),
              )
              .then(delay: const Duration(milliseconds: 1400))
              .slide(
                begin: Offset.zero,
                end: Offset(
                  widget.outAxis == AnimAxis.X ? 0.25 : 0,
                  widget.outAxis == AnimAxis.Y ? 0.25 : 0,
                ),
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1200),
              )
              .blur(
                begin: Offset.zero,
                end: const Offset(
                  6,
                  6,
                ),
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1200),
              ),
        ),
      ],
    )
        .animate()
        .slide(
          begin: Offset(
            widget.inAxis == AnimAxis.X ? 1 : 0,
            widget.inAxis == AnimAxis.Y ? 1 : 0,
          ),
          end: Offset.zero,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 600),
        )
        .then(delay: const Duration(milliseconds: 2000))
        .slide(
          begin: Offset.zero,
          end: Offset(
            widget.outAxis == AnimAxis.X ? -0.5 : 0,
            widget.outAxis == AnimAxis.Y ? -0.5 : 0,
          ),
          curve: Curves.ease,
          duration: const Duration(milliseconds: 1000),
        )
        .blur(
          begin: Offset.zero,
          end: const Offset(
            1,
            1,
          ),
          curve: Curves.ease,
          duration: const Duration(milliseconds: 1000),
        );
  }
}

class CenterRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, (size.height / 2) - 100),
          Offset(size.width, (size.height / 2) + 100),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomRightRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(size.width / 2, (size.height / 2) + 100),
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

class BottomLefttRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, (size.height / 2) + 100),
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

class TriangleRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path()
      ..moveTo(0, (size.height / 2) + 100)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 1.5, size.height)
      ..lineTo(0, (size.height / 2) + 100);

    Path path2 = Path()
      ..lineTo(size.width / 1.5, (size.height / 2) - 100)
      ..lineTo(size.width / 1.5, 0)
      ..lineTo(0, 0);

    path1.addPath(path2, Offset(size.width / 3, 0));

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CenterDiamond extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var points = [
      Offset(size.width / 2, (size.height / 2) - 100), // point p1
      Offset(0, size.height / 2), // point p2
      Offset(size.width / 2, (size.height / 2) + 100), // point p3
      Offset(size.width, size.height / 2) // point p4
    ];

    Path path = Path()
      ..addPolygon(points, false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
