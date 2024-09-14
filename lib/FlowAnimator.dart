import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animation_practice/CutoutAnimations.dart';
import 'package:flutter_animation_practice/RevealAnimations.dart';
import 'package:flutter_animation_practice/models/AnimationModel.dart';
import 'package:flutter_animation_practice/models/AnimatorModel.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class FlowAnimator extends StatefulWidget {
  final AnimatorModel animatorModel;
  final Function() onExitAnimation;

  const FlowAnimator({
    required this.animatorModel,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<FlowAnimator> createState() => _FlowAnimatorState();
}

class _FlowAnimatorState extends State<FlowAnimator> {
  @override
  void initState() {
    super.initState();
    if (widget.animatorModel.endPageAnimation is! RevealAnimation) {
      Future.delayed(
        Duration(
          milliseconds: widget.animatorModel.endPageAnimation.delayInMilli,
        ),
        () {
          widget.onExitAnimation();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF000000),
      child: Stack(
        children: [
          WidgetAnimator(
            startAnimation: widget.animatorModel.startBackgroundAnimation,
            endAnimation: widget.animatorModel.endBackgroundAnimation,
            child: widget.animatorModel.backgroundWidget,
          ),
          WidgetAnimator(
            startAnimation: widget.animatorModel.startForegroundAnimation,
            endAnimation: widget.animatorModel.endForegroundAnimation,
            child: widget.animatorModel.foregroundWidget,
          ),
        ],
      )
          .animate(
            delay: Duration(
              milliseconds:
                  widget.animatorModel.startPageAnimation.delayInMilli,
            ),
            onComplete: (controller) {
              widget.onExitAnimation();
            },
          )
          .slideX(
            begin: widget.animatorModel.startPageAnimation is RevealAnimation
                ? 0
                : 2,
            end: 0,
            curve: Curves.ease,
            duration: Duration(
              milliseconds:
                  widget.animatorModel.startPageAnimation.durationInMilli,
            ),
          )
          .then(
            delay: Duration(
              milliseconds: widget.animatorModel.endPageAnimation.delayInMilli,
            ),
          )
          .slideX(
            begin: 0,
            end: widget.animatorModel.endPageAnimation is RevealAnimation
                ? 0
                : -0.75,
            curve: Curves.ease,
            duration: Duration(
              milliseconds:
                  widget.animatorModel.endPageAnimation.durationInMilli,
            ),
          ),
    );
  }
}

class WidgetAnimator extends StatefulWidget {
  final AnimationModel startAnimation;
  final AnimationModel endAnimation;
  final Widget child;

  const WidgetAnimator({
    required this.startAnimation,
    required this.endAnimation,
    required this.child,
    super.key,
  });

  @override
  State<WidgetAnimator> createState() => _WidgetAnimatorState();
}

class _WidgetAnimatorState extends State<WidgetAnimator> {
  bool startAnimationCompleted = false;

  @override
  Widget build(BuildContext context) {
    return !startAnimationCompleted
        ? getAnimationWidget(
            widget.startAnimation,
            widget.child,
            () {
              setState(() {
                startAnimationCompleted = true;
              });
            },
            false,
          )
        : getAnimationWidget(
            widget.endAnimation,
            widget.child,
            () {},
            true,
          );
  }

  Widget getAnimationWidget(AnimationModel model, Widget child,
      Function() onExitAnimation, bool exitAnimation) {
    switch (model) {
      case RevealAnimation():
        return WidgetRevealAnimtaion(
          key: Key(uuid.v4()),
          delayInMilli: model.delayInMilli,
          durationInMilli: model.durationInMilli,
          forward: !exitAnimation,
          onExitAnimation: onExitAnimation,
          child: child,
        );
      case CutoutAnimation():
        return WidgetCutoutAnimtaion(
          key: Key(uuid.v4()),
          delayInMilli: model.delayInMilli,
          durationInMilli: model.durationInMilli,
          forward: !exitAnimation,
          onExitAnimation: onExitAnimation,
          child: child,
        );
      case ImageParallaxAnimation():
        return WidgetRevealAnimtaion(
          key: Key(uuid.v4()),
          delayInMilli: model.delayInMilli,
          durationInMilli: model.durationInMilli,
          forward: !exitAnimation,
          onExitAnimation: onExitAnimation,
          child: child,
        );
    }
  }
}
