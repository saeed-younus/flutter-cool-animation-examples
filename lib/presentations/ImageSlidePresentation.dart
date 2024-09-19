import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/ImageGlassParallaxEffect.dart';
import 'package:flutter_animation_practice/widgets/CustomRawImage.dart';

class ImageSlidePresentation extends StatefulWidget {
  final List<String> phrases;
  final List<ui.Image> images;
  final VoidCallback onExitAnimationStarted;

  const ImageSlidePresentation({
    required this.phrases,
    required this.images,
    required this.onExitAnimationStarted,
    super.key,
  });

  @override
  State<ImageSlidePresentation> createState() => _ImageSlidePresentationState();
}

class _ImageSlidePresentationState extends State<ImageSlidePresentation> {
  ImageParallaxAnimAxis? lastOutAxis;
  final Random random = Random();

  final List<Widget> slides = [];

  int currentIndex = 0;

  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
  }

  void setSlide([bool fromBuild = false]) {
    if (fromBuild) {
      if (!isFirstTime) return;
    }

    if (currentIndex == widget.phrases.length) {
      widget.onExitAnimationStarted();
      return;
    }

    isFirstTime = false;

    slides.insert(
      0,
      getNextSlide(widget.phrases[currentIndex]),
    );
    if (slides.length >= 3) {
      slides.removeAt(slides.length - 1);
    }
    currentIndex++;

    setState(() {});
  }

  Widget getNextSlide(String phrase) {
    // imagees animation
    final randomOutInt = Random().nextInt(3);
    final outAxis = randomOutInt == 0 ? X() : (randomOutInt == 1 ? Y() : Z());

    ImageParallaxAnimAxis inAxis;
    if (lastOutAxis != null) {
      inAxis = lastOutAxis!;
    } else {
      final randomInInt = Random().nextInt(3);
      inAxis = randomInInt == 0 ? X() : (randomInInt == 1 ? Y() : Z());
    }

    lastOutAxis = outAxis;

    return ImageParallaxEffectAnimation(
      key: ValueKey(phrase),
      isFirst: currentIndex == 0,
      // inAxis: Z(),
      // outAxis: Z(),
      inAxis: inAxis,
      outAxis: outAxis,
      background: Stack(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: CustomRawImage(
              image: widget.images[random.nextInt(6)],
            ),
          ),
          Container(
            color: Colors.black12,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: const SizedBox(),
          ),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(48),
          //     child: FittedBox(
          //       fit: BoxFit.cover,
          //       child: Text(
          //         phrase,
          //         maxLines: 1,
          //         textAlign: TextAlign.center,
          //         style: Theme.of(context).textTheme.displayLarge?.copyWith(
          //               color: Colors.white,
          //               fontWeight: ui.FontWeight.w900,
          //             ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      foreground: FittedBox(
        fit: BoxFit.cover,
        child: Center(
          child: Text(
            phrase,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: ui.FontWeight.w900,
                ),
          ),
        ),
      ),
      onExitAnimation: () {
        setSlide();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setSlide(true);
    return Stack(
      children: slides,
    );
  }
}
