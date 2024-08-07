import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TwoWordsAnimation extends StatefulWidget {
  final String word1;
  final String word2;
  final Function() onExitAnimation;

  const TwoWordsAnimation(
    this.word1,
    this.word2, {
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<TwoWordsAnimation> createState() => _TwoWordsAnimationState();
}

class _TwoWordsAnimationState extends State<TwoWordsAnimation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 32,
                color: Colors.amber,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width - 136,
            height: MediaQuery.of(context).size.width - 136,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 136,
              height: MediaQuery.of(context).size.width - 136,
            ),
          )
              .animate(
                  // delay: const Duration(milliseconds: 5500),
                  )
              .scaleXY(
                begin: 0,
                end: 1,
                curve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 400),
              )
              .blur(
                begin: const Offset(10, 4),
                end: const Offset(0, 0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
              )
              .then(delay: const Duration(milliseconds: 1800))
              .scaleXY(
                begin: 1,
                end: 1.5,
                curve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 400),
              )
              .then(delay: const Duration(milliseconds: 1000))
              .scaleXY(
                begin: 1.5,
                end: 0,
                curve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 400),
              ),
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: 200,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                widget.word1,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0.77,
                      letterSpacing: -2,
                    ),
              )
                  .animate(
                    delay: const Duration(milliseconds: 200),
                    // delay: const Duration(milliseconds: 5700),
                  )
                  .scaleXY(
                    begin: 0,
                    end: 1.2,
                    curve: Curves.easeOutBack,
                    duration: const Duration(milliseconds: 400),
                  )
                  .blur(
                    begin: const Offset(10, 4),
                    end: const Offset(0, 0),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                  )
                  .then(delay: const Duration(milliseconds: 1500))
                  .blurX(
                    begin: 0,
                    end: 30,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                  )
                  .slideX(
                    begin: 0,
                    end: -4,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                  ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: 200,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                widget.word2,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 0.77,
                      letterSpacing: -2,
                    ),
              )
                  .animate(
                    delay: const Duration(milliseconds: 2000),
                    // delay: const Duration(milliseconds: 7500),
                  )
                  .blurX(
                    begin: 30,
                    end: 0,
                    duration: const Duration(milliseconds: 400),
                    curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                  )
                  .slideX(
                    begin: 4,
                    end: 0,
                    duration: const Duration(milliseconds: 400),
                    curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                  )
                  .then(delay: const Duration(milliseconds: 1100))
                  .scaleXY(
                    begin: 1,
                    end: 0,
                    curve: Curves.easeOutBack,
                    duration: const Duration(milliseconds: 400),
                  ),
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 32,
                color: Colors.amber,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              shape: BoxShape.circle,
            ),
            width: MediaQuery.of(context).size.width - 136,
            height: MediaQuery.of(context).size.width - 136,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 136,
              height: MediaQuery.of(context).size.width - 136,
            ),
          )
              .animate(
                // delay: const Duration(milliseconds: 5500),
                onComplete: (controller) {
                  widget.onExitAnimation();
                },
              )
              .scaleXY(
                begin: 0,
                end: 1,
                curve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 450),
              )
              .blur(
                begin: const Offset(10, 4),
                end: const Offset(0, 0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
              )
              .then(delay: const Duration(milliseconds: 1800))
              .scaleXY(
                begin: 1,
                end: 1.5,
                curve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 450),
              )
              .then(
                delay: const Duration(milliseconds: 1000),
              )
              .scaleXY(
                begin: 1.5,
                end: 0,
                curve: Curves.easeOutBack,
                duration: const Duration(milliseconds: 450),
              ),
        ),
      ],
    );
  }
}
