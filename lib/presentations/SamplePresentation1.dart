import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/presentations/QuotesReveal.dart';

class Samplepresentation1 extends StatefulWidget {
  final List<String> quotes;
  final VoidCallback onExitAnimation;

  const Samplepresentation1({
    required this.quotes,
    required this.onExitAnimation,
    super.key,
  });

  @override
  State<Samplepresentation1> createState() => _Samplepresentation1State();
}

class _Samplepresentation1State extends State<Samplepresentation1> {
  final List<Widget> _widgets = [];
  int selectedInted = 0;

  final sperateCharacters = [true, false, true, false];
  final xAxisList = [true, true, false, false];
  final outGoingxAxisList = [true, false, false, true];

  @override
  void initState() {
    super.initState();

    addWidget(true);
  }

  void addWidget(bool fromInitState) {
    if (selectedInted >= 4) {
      widget.onExitAnimation();
      return;
    }
    _widgets.add(
      QuotesReveal(
        key: widget.key,
        onExitAnimation: () {
          addWidget(false);
        },
        quote: widget.quotes[selectedInted],
        seperateCharacter: sperateCharacters[selectedInted],
        xAxis: xAxisList[selectedInted],
        outGoingXAxis: outGoingxAxisList[selectedInted],
      ),
    );

    selectedInted++;

    if (!fromInitState) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _widgets,
    );
  }
}
