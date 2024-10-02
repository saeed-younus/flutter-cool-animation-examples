import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback backgroundImagePressed;
  final VoidCallback kineticAnimationPressed;
  final VoidCallback oneWordAnimationExample;
  final VoidCallback twoWordAnimationExample;
  final VoidCallback threeWordAnimationExample;
  final VoidCallback fourWordAnimationExample;
  final VoidCallback fiveWordAnimationExample;
  final VoidCallback revealAnimationExample;
  final VoidCallback cutoutAnimationExample;
  final VoidCallback completeQuoteAnimationWithoutBgExample;
  final VoidCallback sample1;
  const EmptyWidget({
    required this.backgroundImagePressed,
    required this.kineticAnimationPressed,
    required this.oneWordAnimationExample,
    required this.twoWordAnimationExample,
    required this.threeWordAnimationExample,
    required this.fourWordAnimationExample,
    required this.fiveWordAnimationExample,
    required this.revealAnimationExample,
    required this.cutoutAnimationExample,
    required this.completeQuoteAnimationWithoutBgExample,
    required this.sample1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info,
              size: 48,
              color: Colors.amber,
            )
                .animate()
                .scale(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                )
                .fadeIn(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            Text(
              "Select Animation",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            )
                .animate()
                .slideY(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                )
                .blurY(
                  begin: 15,
                  end: 0,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: backgroundImagePressed,
              child: const Text('Background Image Animation'),
            )
                .animate()
                .slideX(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                )
                .blurX(
                  begin: 15,
                  end: 0,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: kineticAnimationPressed,
              child: const Text('Example kinetic Animation'),
            )
                .animate()
                .fadeIn(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                )
                .blurXY(
                  begin: 15,
                  end: 0,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: oneWordAnimationExample,
              child: const Text('One Word animation'),
            )
                .animate()
                .slideX(
                  begin: 1,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                )
                .blurX(
                  begin: 15,
                  end: 0,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: twoWordAnimationExample,
              child: const Text('Two Word animation'),
            )
                .animate()
                .slideY(
                  begin: 1,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                )
                .blurY(
                  begin: 15,
                  end: 0,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: threeWordAnimationExample,
              child: const Text('Three Word animation'),
            ).animate().flipV(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: fourWordAnimationExample,
              child: const Text('Four Word animation'),
            ).animate().flipH(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: fiveWordAnimationExample,
              child: const Text('Five Word animation'),
            ).animate().scaleXY(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: revealAnimationExample,
              child: const Text('Reveal animation'),
            ).animate().shake(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: cutoutAnimationExample,
              child: const Text('Cutout animation'),
            ).animate().shimmer(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: completeQuoteAnimationWithoutBgExample,
              child: const Text('Quote animation Without bg'),
            ).animate().shakeY(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
            ElevatedButton(
              onPressed: sample1,
              child: const Text('Sample 1'),
            ).animate().fadeIn(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1000),
                ),
          ],
        ),
      ),
    );
  }
}
