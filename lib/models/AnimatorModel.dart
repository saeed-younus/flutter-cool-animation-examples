import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/models/AnimationModel.dart';

class AnimatorModel {
  /// Page Animations
  final AnimationModel startPageAnimation;
  final AnimationModel endPageAnimation;

  /// Bg Animations
  final AnimationModel startBackgroundAnimation;
  final AnimationModel endBackgroundAnimation;

  /// Fg Animations
  final AnimationModel startForegroundAnimation;
  final AnimationModel endForegroundAnimation;

  /// Widgets
  final Widget backgroundWidget;
  final Widget foregroundWidget;

  const AnimatorModel({
    required this.startPageAnimation,
    required this.endPageAnimation,
    required this.startBackgroundAnimation,
    required this.endBackgroundAnimation,
    required this.startForegroundAnimation,
    required this.endForegroundAnimation,
    required this.backgroundWidget,
    required this.foregroundWidget,
  });
}
