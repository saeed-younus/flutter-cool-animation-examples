import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FourWordsAnimation extends StatefulWidget {
  final String word1;
  final String word2;
  final String word3;
  final String word4;
  final Function() onExitAnimation;

  const FourWordsAnimation(
    this.word1,
    this.word2,
    this.word3,
    this.word4, {
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<FourWordsAnimation> createState() => _FourWordsAnimationState();
}

class _FourWordsAnimationState extends State<FourWordsAnimation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.amber,
        )
            .animate(
                // delay: const Duration(milliseconds: 9300),
                )
            .scaleX(
              begin: 0,
              end: 1,
              curve: Curves.easeOutBack,
              duration: const Duration(milliseconds: 400),
            )
            .slideX(
              begin: 1,
              end: 0,
              curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              duration: const Duration(milliseconds: 400),
            ),
        Center(
          child: SizedBox(
            height: 96,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 48,
                    width: 200,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        widget.word2,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  height: 0.77,
                                  letterSpacing: -2,
                                ),
                      ),
                    ),
                  )
                      .animate(
                        delay: const Duration(milliseconds: 500),
                        // delay: const Duration(milliseconds: 9800),
                      )
                      .scaleY(
                        begin: 0,
                        end: 1,
                        curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                        duration: const Duration(milliseconds: 100),
                      )
                      .then(delay: const Duration(milliseconds: 700))
                      .slideY(
                        begin: 0,
                        end: 0.5,
                        curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                        duration: const Duration(milliseconds: 400),
                      ),
                ),
                Center(
                  child: Container(
                    height: 48,
                    width: 200,
                    color: Colors.amber,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        widget.word1,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  height: 0.77,
                                  letterSpacing: -2,
                                ),
                      ),
                    ),
                  )
                      .animate(
                          // delay: const Duration(milliseconds: 9300),
                          )
                      .slideX(
                        begin: -10,
                        end: 0,
                        curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                        duration: const Duration(milliseconds: 400),
                      )
                      .blurX(
                        begin: 30,
                        end: 0,
                        duration: const Duration(milliseconds: 400),
                        curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                      )
                      .then(delay: const Duration(milliseconds: 1000))
                      .slideY(
                        begin: 0,
                        end: -0.5,
                        duration: const Duration(milliseconds: 400),
                        curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                      ),
                ),
              ],
            ),
          )
              .animate(
                delay: const Duration(milliseconds: 2200),
                // delay: const Duration(milliseconds: 11500),
              )
              .slideY(
                begin: 0,
                end: 0,
                duration: const Duration(milliseconds: 400),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              ),
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: 200,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                widget.word3,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0.77,
                      letterSpacing: -2,
                      color: Colors.white,
                    ),
              ),
            ),
          )
              .animate(
                delay: const Duration(milliseconds: 2200),
                // delay: const Duration(milliseconds: 11500),
              )
              .slideY(
                begin: 0,
                end: 2,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .slideX(
                begin: -10,
                end: 0,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .blurX(
                begin: 30,
                end: 0,
                duration: const Duration(milliseconds: 400),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              ),
        ),
        Center(
          child: Container(
            width: 200,
            height: 2,
            color: Colors.white,
          )
              .animate(
                delay: const Duration(milliseconds: 2200),
                // delay: const Duration(milliseconds: 11500),
              )
              .slideY(
                begin: 0,
                end: 27,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .slideX(
                begin: 10,
                end: 0,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .blurX(
                begin: 30,
                end: 0,
                duration: const Duration(milliseconds: 400),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              ),
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: 200,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                widget.word4,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0.77,
                      letterSpacing: -2,
                      color: Colors.white,
                    ),
              ),
            ),
          )
              .animate(
                delay: const Duration(milliseconds: 2200),
                // delay: const Duration(milliseconds: 11500),
              )
              .slideY(
                begin: 0,
                end: -2,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .slideX(
                begin: 10,
                end: 0,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .blurX(
                begin: 30,
                end: 0,
                duration: const Duration(milliseconds: 400),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              ),
        ),
        Center(
          child: Container(
            width: 200,
            height: 2,
            color: Colors.white,
          )
              .animate(
                delay: const Duration(milliseconds: 2200),
                // delay: const Duration(milliseconds: 11500),
              )
              .slideY(
                begin: 0,
                end: -27,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .slideX(
                begin: -10,
                end: 0,
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                duration: const Duration(milliseconds: 400),
              )
              .blurX(
                begin: 30,
                end: 0,
                duration: const Duration(milliseconds: 400),
                curve: const Cubic(0.175, 0.885, 0.32, 1.1),
              ),
        ),
      ],
    )
        .animate(
            delay: const Duration(milliseconds: 3000),
            onPlay: (controller) {
              widget.onExitAnimation();
            })
        .slideY(
          begin: 0,
          end: 1.5,
          duration: const Duration(milliseconds: 400),
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        )
        .blurY(
          begin: 0,
          end: 30,
          duration: const Duration(milliseconds: 400),
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        );
  }
}
