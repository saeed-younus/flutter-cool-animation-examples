import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:collection/collection.dart';

class QuotesReveal extends StatefulWidget {
  final VoidCallback onExitAnimation;
  final String quote;
  final bool seperateCharacter;
  final bool xAxis;
  final bool outGoingXAxis;

  const QuotesReveal({
    required this.onExitAnimation,
    required this.quote,
    required this.seperateCharacter,
    required this.xAxis,
    required this.outGoingXAxis,
    super.key,
  });

  @override
  State<QuotesReveal> createState() => _QuotesRevealState();
}

class _QuotesRevealState extends State<QuotesReveal> {
  int randomIndex = 0;
  List<String> result = [];

  @override
  void initState() {
    super.initState();
    int maxLength = 14;

    List<String> parts = widget.quote.split(RegExp(r'[ .]+'));
    String currentLine = '';

    for (String part in parts) {
      if ((currentLine.length + part.length + 1) <= maxLength) {
        // Add part to current line if it fits
        if (currentLine.isEmpty) {
          currentLine = part;
        } else {
          currentLine = '$currentLine $part';
        }
      } else {
        // Add the current line to the result and start a new one
        result.add(currentLine);
        currentLine = part;
      }
    }

    // Add the last line if it exists
    if (currentLine.isNotEmpty) {
      result.add(currentLine);
    }

    Future.delayed(
      Duration(
        milliseconds: (result.length * 1000) + 1000,
      ),
      () {
        widget.onExitAnimation();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...result.mapIndexed(
                  (index, lineText) => QuoteRevealItem(
                    lineText: lineText,
                    index: index,
                    seperateCharacter: widget.seperateCharacter,
                    xAxis: widget.xAxis,
                  ),
                ),
              ],
            ),
          ],
        )
            .animate(
              delay: Duration(
                milliseconds: (result.length * 1000) + 500,
              ),
            )
            .slideX(
              begin: 0,
              end: widget.outGoingXAxis ? -1 : 0,
              duration: const Duration(
                milliseconds: 500,
              ),
            )
            .slideY(
              begin: 0,
              end: widget.outGoingXAxis ? 0 : -1,
              duration: const Duration(
                milliseconds: 500,
              ),
            )
            .blurX(
              begin: 0,
              end: widget.outGoingXAxis ? 20 : 0,
              duration: const Duration(
                milliseconds: 500,
              ),
            )
            .blurY(
              begin: 0,
              end: widget.outGoingXAxis ? 0 : 20,
              duration: const Duration(
                milliseconds: 500,
              ),
            ),
      ),
    );
  }
}

class QuoteRevealItem extends StatelessWidget {
  final String lineText;
  final int index;
  final bool seperateCharacter;
  final bool xAxis;

  const QuoteRevealItem({
    super.key,
    required this.lineText,
    required this.index,
    required this.seperateCharacter,
    required this.xAxis,
  });

  @override
  Widget build(BuildContext context) {
    return seperateCharacter
        ? SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...lineText.split('').mapIndexed(
                  (indexString, char) {
                    return ClipRect(
                      child: xAxis
                          ? Text(
                              char,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ).animate().slideX(
                                begin: 1,
                                end: 0,
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                delay: Duration(
                                  milliseconds:
                                      (index * 1000) + (indexString * 50),
                                ),
                                curve: Curves.ease,
                              )
                          : Text(
                              char,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ).animate().slideY(
                                begin: 1,
                                end: 0,
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                delay: Duration(
                                  milliseconds:
                                      (index * 1000) + (indexString * 50),
                                ),
                                curve: Curves.ease,
                              ),
                    );
                  },
                ),
              ],
            ),
          )
        : SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...lineText.split(' ').mapIndexed(
                      (indexString, word) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRect(
                          child: xAxis
                              ? Text(
                                  word,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                ).animate().slideX(
                                    begin: 1,
                                    end: 0,
                                    duration: const Duration(
                                      milliseconds: 400,
                                    ),
                                    delay: Duration(
                                      milliseconds:
                                          (index * 1000) + (indexString * 250),
                                    ),
                                    curve: Curves.ease,
                                  )
                              : Text(
                                  word,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                ).animate().slideY(
                                    begin: 1,
                                    end: 0,
                                    duration: const Duration(
                                      milliseconds: 600,
                                    ),
                                    delay: Duration(
                                      milliseconds: index * 1000,
                                    ),
                                    curve: Curves.ease,
                                  ),
                        ),
                      ),
                    ),
              ],
            ),
          );
  }
}
