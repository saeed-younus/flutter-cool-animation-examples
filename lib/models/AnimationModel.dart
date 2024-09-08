import 'package:flutter_animation_practice/CutoutAnimations.dart';
import 'package:flutter_animation_practice/ImageGlassParallaxEffect.dart';
import 'package:flutter_animation_practice/RevealAnimations.dart';

sealed class AnimationModel<T extends Object> {
  final int delayInMilli;
  final int durationInMilli;
  final T type;

  const AnimationModel({
    required this.delayInMilli,
    required this.durationInMilli,
    required this.type,
  });
}

class RevealAnimation extends AnimationModel<Reveals> {
  const RevealAnimation({
    required super.delayInMilli,
    required super.durationInMilli,
    required super.type,
  });
}

class CutoutAnimation extends AnimationModel<Cutouts> {
  const CutoutAnimation({
    required super.delayInMilli,
    required super.durationInMilli,
    required super.type,
  });
}

class ImageParallaxAnimation extends AnimationModel<ImageParallaxAnimAxis> {
  const ImageParallaxAnimation({
    required super.delayInMilli,
    required super.durationInMilli,
    required super.type,
  });
}
