import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/RevealAnimations.dart';
import 'package:flutter_animation_practice/models/AnimationModel.dart';
import 'package:flutter_animation_practice/models/AnimatorModel.dart';

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
  Widget build(BuildContext context) {
    return Stack(
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
          )
        : getAnimationWidget(
            widget.endAnimation,
            widget.child,
            () {},
          );
  }

  Widget getAnimationWidget(
      AnimationModel model, Widget child, Function() onExitAnimation) {
    switch (model) {
      case RevealAnimation():
        return WidgetRevealAnimtaion(
          onExitAnimation: onExitAnimation,
          child: child,
        );
      case CutoutAnimation():
        return WidgetRevealAnimtaion(
          onExitAnimation: onExitAnimation,
          child: child,
        );
      case ImageParallaxAnimation():
        return WidgetRevealAnimtaion(
          onExitAnimation: onExitAnimation,
          child: child,
        );
    }
  }
}
