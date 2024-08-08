import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

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
                  duration: const Duration(milliseconds: 500),
                )
                .fadeIn(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 500),
                ),
            Text(
              "Animation Ended. Please Pressed Animation or random animation button to play the animation.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            )
                .animate()
                .slideY(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 500),
                )
                .blurY(
                  begin: 15,
                  end: 0,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 500),
                ),
          ],
        ),
      ),
    );
  }
}
