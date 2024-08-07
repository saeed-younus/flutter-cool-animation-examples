import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ThreeWordAnimation extends StatefulWidget {
  final String word1;
  final String word2;
  final String word3;
  final Function() exitAnimationStarted;

  const ThreeWordAnimation(
    this.word1,
    this.word2,
    this.word3, {
    required this.exitAnimationStarted,
    super.key,
  });

  @override
  State<ThreeWordAnimation> createState() => _ThreeWordAnimationState();
}

class _ThreeWordAnimationState extends State<ThreeWordAnimation> {
  bool firstCenterTextAnimCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: firstCenterTextAnimCompleted
                ? Theme.of(context).textTheme.displayLarge!.fontSize! + 48
                : 0,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutBack,
          child: Center(
            child: Text(
              widget.word1,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.amber,
                  ),
            )
                .animate(
                  onComplete: (controller) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        firstCenterTextAnimCompleted = true;
                      });
                    });
                  },
                )
                .blurXY(
                  begin: 10,
                  end: 0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                )
                .scaleXY(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                ),
          ),
        ),
        Center(
          child: Text(
            widget.word2,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          )
              .animate(delay: const Duration(milliseconds: 900))
              .blurY(
                begin: 30,
                end: 0,
                duration: const Duration(milliseconds: 350),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              )
              .slideY(
                begin: 10,
                end: 0,
                duration: const Duration(milliseconds: 350),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              ),
        ),
        Center(
          child: AnimatedPadding(
            padding: EdgeInsets.only(
              top: Theme.of(context).textTheme.displayLarge!.fontSize! +
                  48 +
                  (firstCenterTextAnimCompleted ? 0 : 128),
            ),
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
            child: Text(
              widget.word3,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
                .animate(delay: const Duration(milliseconds: 1400))
                .blurX(
                  begin: 30,
                  end: 0,
                  duration: const Duration(milliseconds: 400),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                )
                .slideX(
                  begin: -8,
                  end: 0,
                  duration: const Duration(milliseconds: 400),
                  curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                ),
          ),
        ),
      ],
    )
        .animate(
          delay: const Duration(milliseconds: 2200),
          onPlay: (controller) {
            widget.exitAnimationStarted();
          },
        )
        .blurY(
          begin: 0,
          end: 60,
          duration: const Duration(milliseconds: 400),
          curve: const Cubic(0.175, 0.885, 0.32, 1.05),
        )
        .slideY(
          begin: 0,
          end: 1,
          duration: const Duration(milliseconds: 400),
          curve: const Cubic(0.175, 0.885, 0.32, 1.05),
        );
  }
}
