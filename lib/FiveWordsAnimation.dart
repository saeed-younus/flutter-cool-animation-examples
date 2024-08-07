import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FiveWordsAnimation extends StatefulWidget {
  final String word1;
  final String word2;
  final String word3;
  final String word4;
  final String word5;
  final Function() exitAnimationStarted;

  const FiveWordsAnimation(
    this.word1,
    this.word2,
    this.word3,
    this.word4,
    this.word5, {
    required this.exitAnimationStarted,
    super.key,
  });

  @override
  State<FiveWordsAnimation> createState() => _FiveWordsAnimationState();
}

class _FiveWordsAnimationState extends State<FiveWordsAnimation> {
  bool firstCenterTextAnimCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            AnimatedPadding(
              padding: EdgeInsets.only(
                top: firstCenterTextAnimCompleted ? 72 : 0,
              ),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              child: Center(
                child: Text(
                  widget.word1,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.amber,
                        fontSize: 60,
                      ),
                )
                    .animate(
                      // delay: const Duration(seconds: 3),
                      onComplete: (controller) {
                        setState(() {
                          firstCenterTextAnimCompleted = true;
                        });
                      },
                    )
                    .blurY(
                      begin: 30,
                      end: 0,
                      duration: const Duration(milliseconds: 500),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    )
                    .slideY(
                      begin: -20,
                      end: 0,
                      duration: const Duration(milliseconds: 500),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    ),
              ),
            ),
            Center(
              child: Text(
                widget.word2,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      letterSpacing: -2,
                    ),
              )
                  .animate(delay: const Duration(milliseconds: 500))
                  // .animate(delay: const Duration(milliseconds: 3500))
                  .blurY(
                    begin: 30,
                    end: 0,
                    duration: const Duration(milliseconds: 500),
                    curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                  )
                  .slideY(
                    begin: -20,
                    end: 0,
                    duration: const Duration(milliseconds: 500),
                    curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                  ),
            ),
          ],
        )
            .animate(delay: const Duration(milliseconds: 1000))
            // .animate(delay: const Duration(milliseconds: 4000))
            .rotate(
              begin: 0,
              end: -0.25,
              duration: const Duration(milliseconds: 500),
              curve: const Cubic(0.175, 0.885, 0.32, 1.05),
            )
            .slideX(
              begin: 0,
              end: -0.4,
              duration: const Duration(milliseconds: 500),
              curve: const Cubic(0.175, 0.885, 0.32, 1.05),
            ),
        Align(
          alignment: const Alignment(-1, 0),
          child: Container(
            margin: const EdgeInsets.only(left: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.word3,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 72,
                        letterSpacing: -1,
                        height: 0.8,
                      ),
                )
                    .animate(
                      delay: const Duration(milliseconds: 1500),
                      // delay: const Duration(milliseconds: 4500),
                    )
                    .blurX(
                      begin: 30,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    )
                    .slideX(
                      begin: 10,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    ),
                Text(
                  widget.word4,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 72,
                        letterSpacing: -1,
                        height: 0.8,
                      ),
                )
                    .animate(
                      delay: const Duration(milliseconds: 1700),
                      // delay: const Duration(milliseconds: 4700),
                    )
                    .blurX(
                      begin: 30,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    )
                    .slideX(
                      begin: 10,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    ),
                Text(
                  widget.word5,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 72,
                        letterSpacing: -1,
                        height: 0.8,
                      ),
                )
                    .animate(
                      delay: const Duration(milliseconds: 1900),
                      // delay: const Duration(milliseconds: 4900),
                    )
                    .blurY(
                      begin: 30,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    )
                    .slideY(
                      begin: 10,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                      curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                    ),
              ],
            ),
          ),
        )
      ],
    )
        .animate(
          delay: const Duration(milliseconds: 2500),
          onPlay: (controller) {
            widget.exitAnimationStarted();
          },
        )
        // .animate(delay: const Duration(milliseconds: 5500))
        .scaleXY(
          begin: 1,
          end: 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
        )
        .blur(
          begin: const Offset(0, 0),
          end: const Offset(24, 6),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
        );
  }
}
