import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bordered_text/bordered_text.dart';

class OneWordAnimation extends StatefulWidget {
  final String word1;
  final Function() onExitAnimation;

  const OneWordAnimation(
    this.word1, {
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<OneWordAnimation> createState() => _OneWordAnimationState();
}

class _OneWordAnimationState extends State<OneWordAnimation> {
  bool blackBg = true;

  bool startAnimationCompleted = false;

  late final List<Widget> wordList = List.generate(
    12,
    (index) => Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: RandomCharacterAppearAnimation(
          widget.word1,
          isBlackText: index % 2 == 0,
        ),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();

    runGlitchEffectBg();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: blackBg ? Colors.black : Colors.white,
          child: !startAnimationCompleted
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: wordList,
                ),
        )
            .animate(
              delay: const Duration(milliseconds: 4500),
              onPlay: (controller) {
                widget.onExitAnimation();
              },
            )
            .slideX(
              begin: 0,
              end: 1,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 400),
            ),
      ],
    ).animate(
      onComplete: (controller) {
        setState(() {
          startAnimationCompleted = true;
        });
      },
    ).slideY(
      begin: -1,
      end: 0,
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void runGlitchEffectBg() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    setBgColor(false);
    await Future.delayed(const Duration(milliseconds: 300));
    setBgColor(true);
  }

  void setBgColor(bool isBlack) {
    if (!mounted) return;
    setState(() {
      blackBg = isBlack;
    });
  }
}

class RandomCharacterAppearAnimation extends StatefulWidget {
  final String text;
  final bool isBlackText;

  const RandomCharacterAppearAnimation(
    this.text, {
    required this.isBlackText,
    super.key,
  });

  @override
  State<RandomCharacterAppearAnimation> createState() =>
      _RandomCharacterAppearAnimationState();
}

class _RandomCharacterAppearAnimationState
    extends State<RandomCharacterAppearAnimation> {
  final startMaxDuration = 1000;
  final endingMaxDuration = 800;
  final Random _random = Random();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        ...List.generate(widget.text.length, (index) {
          int startRandomDuration = getStartRandomDuration();
          int endingRandomDuration = getEndingRandomDuration();
          int remainingDuration = startMaxDuration - startRandomDuration;
          return Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: BorderedText(
                strokeWidth: 2.0,
                strokeColor: widget.isBlackText ? Colors.white : Colors.black,
                child: Text(
                  widget.text[index],
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: widget.isBlackText ? Colors.black : Colors.white,
                        height: 0.77,
                      ),
                ),
              )
                  .animate()
                  .scaleX(
                    begin: 0,
                    end: 1,
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(
                      milliseconds: startRandomDuration,
                    ),
                  )
                  .fade(
                    begin: 0,
                    end: 1,
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(
                      milliseconds: startRandomDuration,
                    ),
                  )
                  .then(
                    delay: Duration(milliseconds: 1500 + remainingDuration),
                  )
                  .slideY(
                    begin: 0,
                    end: 1,
                    curve: Curves.ease,
                    duration: Duration(
                      milliseconds: endingRandomDuration,
                    ),
                  )
                  .fade(
                    begin: 1,
                    end: 0,
                    curve: Curves.ease,
                    duration: Duration(
                      milliseconds: endingRandomDuration,
                    ),
                  ),
            ),
          );
        }),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }

  int getStartRandomDuration() {
    return _random.nextInt(startMaxDuration) + 300;
  }

  int getEndingRandomDuration() {
    return _random.nextInt(endingMaxDuration) + 300;
  }
}
