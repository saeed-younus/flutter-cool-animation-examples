import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/RevealAnimations.dart';
import 'package:flutter_animation_practice/presentations/QuotesReveal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class QuotesWithoutBackground extends StatefulWidget {
  final VoidCallback onExitAnimation;
  final String quote;

  const QuotesWithoutBackground({
    required this.onExitAnimation,
    required this.quote,
    super.key,
  });

  @override
  State<QuotesWithoutBackground> createState() =>
      _QuotesWithoutBackgroundState();
}

class _QuotesWithoutBackgroundState extends State<QuotesWithoutBackground> {
  final List<_SampleTextSettings> _settingsList = [];
  final bool isCircle = Random().nextInt(2) == 1;
  int randomIndex = 0;

  @override
  void initState() {
    super.initState();
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 300),
        characterDelay: const Duration(milliseconds: 0),
        maxLines: 10,
      ),
    );
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 300),
        characterDelay: const Duration(milliseconds: 0),
        maxLines: 10,
      ),
    );
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingScaleDown(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 300),
        characterDelay: const Duration(milliseconds: 0),
        maxLines: 10,
      ),
    );
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingScaleUp(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 300),
        characterDelay: const Duration(milliseconds: 0),
        maxLines: 10,
      ),
    );
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingScaleUp(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 30),
        characterDelay: const Duration(milliseconds: 30),
        maxLines: 10,
      ),
    );
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingScaleDown(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 30),
        characterDelay: const Duration(milliseconds: 30),
        maxLines: 10,
      ),
    );
    _settingsList.add(
      _SampleTextSettings(
        text: widget.quote,
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
          curve: const Cubic(0.175, 0.885, 0.32, 1.1),
        ),
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        atRestEffect: WidgetRestingEffects.none(),
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        initialDelay: const Duration(milliseconds: 500),
        spaceDelay: const Duration(milliseconds: 30),
        characterDelay: const Duration(milliseconds: 30),
        maxLines: 10,
      ),
    );

    randomIndex = Random().nextInt(_settingsList.length);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: WidgetRevealAnimtaion(
          delayInMilli: 0,
          durationInMilli: 500,
          forward: true,
          onExitAnimation: () {},
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: isCircle
                ? const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  )
                : const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: TextAnimator(
              _settingsList[randomIndex].text,
              incomingEffect: _settingsList[randomIndex].incomingEffect,
              outgoingEffect: _settingsList[randomIndex].outgoingEffect,
              atRestEffect: _settingsList[randomIndex].atRestEffect,
              style: _settingsList[randomIndex].style,
              textAlign: _settingsList[randomIndex].textAlign,
              initialDelay: _settingsList[randomIndex].initialDelay,
              spaceDelay: _settingsList[randomIndex].spaceDelay,
              characterDelay: _settingsList[randomIndex].characterDelay,
              maxLines: _settingsList[randomIndex].maxLines,
              onIncomingAnimationComplete: (_) {
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    widget.onExitAnimation();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SampleTextSettings {
  String text;
  WidgetTransitionEffects incomingEffect;
  WidgetTransitionEffects outgoingEffect;
  WidgetRestingEffects atRestEffect;
  int maxLines;
  TextAlign textAlign;
  TextStyle style;
  Duration initialDelay;
  Duration characterDelay;
  Duration spaceDelay;

  _SampleTextSettings(
      {required this.text,
      required this.incomingEffect,
      required this.outgoingEffect,
      required this.atRestEffect,
      required this.maxLines,
      required this.textAlign,
      required this.style,
      required this.initialDelay,
      required this.characterDelay,
      required this.spaceDelay});
}
