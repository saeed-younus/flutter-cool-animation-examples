import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// n = negative axis
// enum ImageParallaxAnimAxis {
//   X,
//   Y,
//   Z;

//   const ImageParallaxAnimAxis({
//     required this.negativeAxis,
//   });

//   final bool negativeAxis;
// }

sealed class ImageParallaxAnimAxis {
  final bool negativeAxis;
  ImageParallaxAnimAxis([this.negativeAxis = false]);
}

class X extends ImageParallaxAnimAxis {
  X([super.negativeAxis]);
}

class Y extends ImageParallaxAnimAxis {
  Y([super.negativeAxis]);
}

class Z extends ImageParallaxAnimAxis {
  Z([super.negativeAxis]);
}

class ImageParallaxEffectAnimation extends StatefulWidget {
  final ImageParallaxAnimAxis inAxis;
  final ImageParallaxAnimAxis outAxis;
  final Widget background;
  final Widget? foreground;
  final Function() onExitAnimation;

  const ImageParallaxEffectAnimation({
    required this.background,
    this.foreground,
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

  final List<CustomClipper<Path>> _clipperList = [
    CenterDiamond(),
    TriangleRectangle(),
    CenterRectangle(),
    BottomLefttRectangle(),
    BottomRightRectangle(),
    BottomRectangle(),
    TopRectangle(),
    TopLefttRectangle(),
    TopRightRectangle(),
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 3; i++) {
      final randomIndex = _random.nextInt(_clipperList.length);
      final item = _clipperList[randomIndex];
      _customClippers.add(item);
      _clipperList.removeAt(randomIndex);
    }

    // if (_random.nextInt(2) == 0) {
    //   _customClippers.add(CenterDiamond());
    //   _customClippers.add(TriangleRectangle());
    // } else {
    //   _customClippers.add(CenterRectangle());
    //   if (_random.nextInt(2) == 0) {
    //     _customClippers.add(BottomLefttRectangle());
    //   } else {
    //     _customClippers.add(BottomRightRectangle());
    //   }
    // }

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
          child: widget.background
              .animate()
              .scaleXY(
                begin: widget.inAxis is Z ? 1 : 1.2,
                end: 1.2,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 1200),
              )
              .slide(
                begin: widget.inAxis is Z
                    ? Offset.zero
                    : Offset(
                        widget.inAxis is X ? 0.07 : 0,
                        widget.inAxis is Y ? 0.03 : 0,
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
            child: widget.background
                .animate()
                .scaleXY(
                  begin: widget.inAxis is Z ? 0.9 : 1.2,
                  end: 1.2,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1400),
                )
                .slide(
                  begin: Offset(
                    widget.inAxis is X ? 0.15 : 0,
                    widget.inAxis is Y ? 0.1 : 0,
                  ),
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1400),
                )
                // .rotate(
                //   begin: 0.05 * (_random.nextInt(3) - 1),
                //   end: 0,
                //   curve: Curves.ease,
                //   duration: const Duration(milliseconds: 1400),
                // )
                .then(delay: const Duration(milliseconds: 1200))
                .slide(
                  begin: Offset.zero,
                  end: Offset(
                    widget.outAxis is X ? -0.15 : 0,
                    widget.outAxis is Y ? -0.1 : 0,
                  ),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 600),
                ),
          ),
        ),
        SizedBox.expand(
          child: ClipPath(
            clipper: _customClippers[1],
            child: widget.background
                .animate()
                .slide(
                  begin: Offset(
                    widget.inAxis is X ? 0.12 : 0,
                    widget.inAxis is Y ? 0.1 : 0,
                  ),
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1600),
                )
                .scaleXY(
                  begin: widget.inAxis is Z ? 0.8 : 1.2,
                  end: 1.2,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1600),
                )
                // .rotate(
                //   begin: 0.04 * (_random.nextInt(3) - 1),
                //   end: 0,
                //   curve: Curves.ease,
                //   duration: const Duration(milliseconds: 1600),
                // )
                .then(delay: const Duration(milliseconds: 1000))
                .slide(
                  begin: Offset.zero,
                  end: Offset(
                    widget.outAxis is X ? -0.12 : 0,
                    widget.outAxis is Y ? -0.1 : 0,
                  ),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 600),
                ),
          ),
        ),
        SizedBox.expand(
          child: ClipPath(
            clipper: _customClippers[2],
            child: widget.background
                .animate()
                .slide(
                  begin: Offset(
                    widget.inAxis is X ? 0.17 : 0,
                    widget.inAxis is Y ? 0.13 : 0,
                  ),
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1700),
                )
                .scaleXY(
                  begin: widget.inAxis is Z ? 0.7 : 1.2,
                  end: 1.2,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1700),
                )
                // .rotate(
                //   begin: 0.04 * (_random.nextInt(3) - 1),
                //   end: 0,
                //   curve: Curves.ease,
                //   duration: const Duration(milliseconds: 1700),
                // )
                .then(delay: const Duration(milliseconds: 900))
                .slide(
                  begin: Offset.zero,
                  end: Offset(
                    widget.outAxis is X ? -0.17 : 0,
                    widget.outAxis is Y ? -0.13 : 0,
                  ),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 600),
                ),
          ),
        ),
        widget.foreground == null
            ? const SizedBox()
            : Container(
                color: const Color(0x11000000),
                width: double.infinity,
                height: double.infinity,
                child: const SizedBox(),
              ),
        widget.foreground == null
            ? const SizedBox()
            : widget.foreground!
                .animate()
                .fade(
                  begin: 0.3,
                  end: 1,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1200),
                )
                .slide(
                  begin: Offset(
                    widget.inAxis is X ? 0.5 : 0,
                    widget.inAxis is Y ? 2 : 0,
                  ),
                  end: Offset.zero,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 1200),
                )
                .then(delay: const Duration(milliseconds: 1400))
                .slide(
                  begin: Offset.zero,
                  end: Offset(
                    widget.outAxis is X ? 0.25 : 0,
                    widget.outAxis is Y ? 0.25 : 0,
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
      ],
    )
        .animate()
        .scaleXY(
          begin: widget.inAxis is Z ? 1 : 1,
          end: 1,
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 600),
        )
        .fade(
          begin: widget.inAxis is Z ? 0 : 1,
          end: 1,
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 600),
        )
        .slide(
          begin: Offset(
            widget.inAxis is X ? 1 : 0,
            widget.inAxis is Y ? 1 : 0,
          ),
          end: Offset.zero,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 600),
        )
        .then(
          delay: Duration(
            milliseconds: 2000 - (widget.outAxis is Z ? 300 : 0),
          ),
        )
        .slide(
          begin: Offset.zero,
          end: Offset(
            widget.outAxis is X ? -1 : 0,
            widget.outAxis is Y ? -1 : 0,
          ),
          curve: Curves.ease,
          duration: const Duration(milliseconds: 600),
        )
        .scaleXY(
          begin: 1,
          end: widget.outAxis is Z ? 3 : 1,
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 600),
        )
        .fade(
          begin: 1,
          end: widget.outAxis is Z ? 0 : 1,
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 600),
        )
        .blur(
          begin: Offset.zero,
          end: const Offset(
            2,
            2,
          ),
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 600),
        );
  }
}

class CenterRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, (size.height / 2) - 150),
          Offset(size.width, (size.height / 2) + 150),
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
          Offset(size.width / 2, (size.height / 2) + 150),
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
          Offset(0, (size.height / 2) + 150),
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

class TopRightRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(size.width / 2, 0),
          Offset(size.width, (size.height / 2) - 150),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TopLefttRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width / 2, (size.height / 2) + 150),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, (size.height / 2) + 150),
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

class TopRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(0, (size.height / 2) + 150),
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

class TriangleRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path()
      ..moveTo(0, (size.height / 2) + 150)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 1.5, size.height)
      ..lineTo(0, (size.height / 2) + 150);

    Path path2 = Path()
      ..lineTo(size.width / 1.5, (size.height / 2) - 150)
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
      Offset(size.width / 2, (size.height / 2) - 150), // point p1
      Offset(0, size.height / 2), // point p2
      Offset(size.width / 2, (size.height / 2) + 150), // point p3
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
