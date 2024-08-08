import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animation_practice/EmptyWidget.dart';
import 'package:flutter_animation_practice/FiveWordsAnimation.dart';
import 'package:flutter_animation_practice/FourWordsAnimation.dart';
import 'package:flutter_animation_practice/OneWordAnimation.dart';
import 'package:flutter_animation_practice/ThreeWordsAnimation.dart';
import 'package:flutter_animation_practice/TwoWordsAnimation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool centerTextCompleted = false;
  bool withTextCompleted = false;

  bool startAnimation = false;

  final List<Widget> animationWidgets = [];

  final constantPhrases = [
    ["SEAMLESS"],
    [
      "Boost",
      "Your",
      "Business",
    ],
    [
      "with",
      "Motion Graphics".toUpperCase(),
      "LET",
      "US",
      "CREATE",
    ],
    [
      "LOGO".toUpperCase(),
      "DESIGN".toUpperCase(),
    ],
    [
      "INTRO",
      "OUTRO",
      "INFORMATION",
      "KINETIC",
    ],
  ];

  late List<List<String>> phrases = [];

  Random random = Random();

  @override
  void initState() {
    super.initState();
    initializePhrases();
  }

  void initializePhrases() {
    phrases = constantPhrases.toList();
  }

  void initiateAnimations() {
    animationWidgets.addAll([
      ThreeWordsAnimation(
        "Boost",
        "Your",
        "Business",
        onExitAnimation: () {
          setState(() {
            animationWidgets.addAll([
              FiveWordsAnimation(
                "with",
                "Motion Graphics".toUpperCase(),
                "LET",
                "US",
                "CREATE",
                onExitAnimation: () {
                  setState(() {
                    animationWidgets.addAll([
                      TwoWordsAnimation(
                        "LOGO".toUpperCase(),
                        "DESIGN".toUpperCase(),
                        onExitAnimation: () {
                          setState(() {
                            animationWidgets.addAll([
                              FourWordsAnimation(
                                "INTRO",
                                "OUTRO",
                                "INFORMATION",
                                "KINETIC",
                                onExitAnimation: () {},
                              ),
                            ]);
                          });
                        },
                      ),
                    ]);
                  });
                },
              ),
            ]);
          });
        },
      ),
    ]);
  }

  void randomAnimation() {
    if (phrases.isEmpty) {
      startAnimation = false;
      if (mounted) {
        setState(() {});
      }
      return;
    }

    int randomIndex = random.nextInt(phrases.length);

    final phrase = phrases[randomIndex];
    phrases.removeAt(randomIndex);

    animationWidgets.add(getAnimationWidget(phrase));
    if (mounted) {
      setState(() {});
    }
  }

  Widget getAnimationWidget(List<String> phrase) {
    if (phrase.length == 1) {
      return OneWordAnimation(
        phrase[0],
        onExitAnimation: () {
          randomAnimation();
        },
      );
    } else if (phrase.length == 2) {
      return TwoWordsAnimation(
        phrase[0],
        phrase[1],
        onExitAnimation: () {
          randomAnimation();
        },
      );
    } else if (phrase.length == 3) {
      return ThreeWordsAnimation(
        phrase[0],
        phrase[1],
        phrase[2],
        onExitAnimation: () {
          randomAnimation();
        },
      );
    } else if (phrase.length == 4) {
      return FourWordsAnimation(
        phrase[0],
        phrase[1],
        phrase[2],
        phrase[3],
        onExitAnimation: () {
          randomAnimation();
        },
      );
    } else if (phrase.length == 5) {
      return FiveWordsAnimation(
        phrase[0],
        phrase[1],
        phrase[2],
        phrase[3],
        phrase[4],
        onExitAnimation: () {
          randomAnimation();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          const Expanded(child: SizedBox()),
          FloatingActionButton.extended(
            icon: Icon(startAnimation ? Icons.stop : Icons.play_arrow),
            label: const Text("Random Animation"),
            onPressed: () {
              setState(() {
                animationWidgets.clear();
                startAnimation = !startAnimation;

                if (startAnimation) {
                  initializePhrases();
                  randomAnimation();
                }
              });
            },
          ),
          const Expanded(child: SizedBox()),
          FloatingActionButton.extended(
            icon: Icon(startAnimation ? Icons.stop : Icons.play_arrow),
            label: const Text("Animation"),
            onPressed: () {
              setState(() {
                animationWidgets.clear();
                startAnimation = !startAnimation;

                if (startAnimation) {
                  initiateAnimations();
                }
              });
            },
          ),
        ],
      ),
      body: !startAnimation
          ? const EmptyWidget()
          : Stack(
              children: [
                ...animationWidgets,
                // ThreeWordAnimation(
                //   "Boost",
                //   "Your",
                //   "Business",
                //   exitAnimationStarted: () {
                //     print("exitAnimationStarted");
                //   },
                // ),
                // FiveWordsAnimation(
                //   "with",
                //   "Motion Graphics".toUpperCase(),
                //   "LET",
                //   "US",
                //   "CREATE",
                // ),
                // TwoWordsAnimation(
                //   "Logo".toUpperCase(),
                //   "Design".toUpperCase(),
                // ),
                // const FourWordsAnimation(
                //   "INTRO",
                //   "OUTRO",
                //   "INFORMATION",
                //   "KINTEIC",
                // ),

                // Stack(
                //   children: [
                //     AnimatedPadding(
                //       padding: EdgeInsets.only(
                //         bottom: centerTextCompleted
                //             ? Theme.of(context)
                //                     .textTheme
                //                     .displayLarge!
                //                     .fontSize! +
                //                 48
                //             : 0,
                //       ),
                //       duration: const Duration(milliseconds: 500),
                //       curve: Curves.easeOutBack,
                //       child: Center(
                //         child: Text(
                //           "Boost",
                //           style: Theme.of(context)
                //               .textTheme
                //               .displayLarge
                //               ?.copyWith(
                //                 fontWeight: FontWeight.w900,
                //                 color: Colors.amber,
                //               ),
                //         )
                //             .animate(
                //               onComplete: (controller) {
                //                 Future.delayed(
                //                     const Duration(milliseconds: 500), () {
                //                   setState(() {
                //                     centerTextCompleted = true;
                //                   });
                //                 });
                //               },
                //             )
                //             .blurXY(
                //               begin: 10,
                //               end: 0,
                //               duration: const Duration(milliseconds: 400),
                //               curve: Curves.easeOutBack,
                //             )
                //             .scaleXY(
                //               duration: const Duration(milliseconds: 400),
                //               curve: Curves.easeOutBack,
                //             ),
                //       ),
                //     ),
                //     Center(
                //       child: Text(
                //         "Your",
                //         style:
                //             Theme.of(context).textTheme.displayLarge?.copyWith(
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //       )
                //           .animate(delay: const Duration(milliseconds: 900))
                //           .blurY(
                //             begin: 30,
                //             end: 0,
                //             duration: const Duration(milliseconds: 350),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           )
                //           .slideY(
                //             begin: 10,
                //             end: 0,
                //             duration: const Duration(milliseconds: 350),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           ),
                //     ),
                //     Center(
                //       child: AnimatedPadding(
                //         padding: EdgeInsets.only(
                //           top: Theme.of(context)
                //                   .textTheme
                //                   .displayLarge!
                //                   .fontSize! +
                //               48 +
                //               (centerTextCompleted ? 0 : 128),
                //         ),
                //         duration: const Duration(milliseconds: 400),
                //         curve: Curves.linear,
                //         child: Text(
                //           "Business",
                //           style: Theme.of(context)
                //               .textTheme
                //               .displayLarge
                //               ?.copyWith(
                //                 fontWeight: FontWeight.bold,
                //               ),
                //         )
                //             .animate(delay: const Duration(milliseconds: 1400))
                //             .blurX(
                //               begin: 30,
                //               end: 0,
                //               duration: const Duration(milliseconds: 400),
                //               curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //             )
                //             .slideX(
                //               begin: -8,
                //               end: 0,
                //               duration: const Duration(milliseconds: 400),
                //               curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //             ),
                //       ),
                //     ),
                //   ],
                // )
                //     .animate(delay: const Duration(seconds: 3))
                //     .blurY(
                //       begin: 0,
                //       end: 60,
                //       duration: const Duration(milliseconds: 400),
                //       curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //     )
                //     .slideY(
                //       begin: 0,
                //       end: 1,
                //       duration: const Duration(milliseconds: 400),
                //       curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //     ),

                // Stack(
                //   children: [
                //     Stack(
                //       children: [
                //         AnimatedPadding(
                //           padding: EdgeInsets.only(
                //             top: withTextCompleted ? 72 : 0,
                //           ),
                //           duration: const Duration(milliseconds: 400),
                //           curve: Curves.easeOutBack,
                //           child: Center(
                //             child: Text(
                //               "with",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displayLarge
                //                   ?.copyWith(
                //                     fontWeight: FontWeight.w900,
                //                     color: Colors.amber,
                //                     fontSize: 60,
                //                   ),
                //             )
                //                 .animate(
                //                   delay: const Duration(seconds: 3),
                //                   onComplete: (controller) {
                //                     setState(() {
                //                       withTextCompleted = true;
                //                     });
                //                   },
                //                 )
                //                 .blurY(
                //                   begin: 30,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 500),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 )
                //                 .slideY(
                //                   begin: -20,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 500),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 ),
                //           ),
                //         ),
                //         Center(
                //           child: Text(
                //             "Motion Graphics".toUpperCase(),
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .displayLarge
                //                 ?.copyWith(
                //                   fontWeight: FontWeight.w900,
                //                   fontSize: 32,
                //                   letterSpacing: -2,
                //                 ),
                //           )
                //               .animate(
                //                   delay: const Duration(milliseconds: 3500))
                //               .blurY(
                //                 begin: 30,
                //                 end: 0,
                //                 duration: const Duration(milliseconds: 500),
                //                 curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //               )
                //               .slideY(
                //                 begin: -20,
                //                 end: 0,
                //                 duration: const Duration(milliseconds: 500),
                //                 curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //               ),
                //         ),
                //       ],
                //     )
                //         .animate(delay: const Duration(milliseconds: 4000))
                //         .rotate(
                //           begin: 0,
                //           end: -0.25,
                //           duration: const Duration(milliseconds: 500),
                //           curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //         )
                //         .slideX(
                //           begin: 0,
                //           end: -0.4,
                //           duration: const Duration(milliseconds: 500),
                //           curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //         ),
                //     Align(
                //       alignment: const Alignment(-1, 0),
                //       child: Container(
                //         margin: const EdgeInsets.only(left: 100),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "LET",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displayLarge
                //                   ?.copyWith(
                //                     fontWeight: FontWeight.w900,
                //                     fontSize: 72,
                //                     letterSpacing: -1,
                //                     height: 0.8,
                //                   ),
                //             )
                //                 .animate(
                //                   delay: const Duration(milliseconds: 4500),
                //                 )
                //                 .blurX(
                //                   begin: 30,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 )
                //                 .slideX(
                //                   begin: 10,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 ),
                //             Text(
                //               "US".toUpperCase(),
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displayLarge
                //                   ?.copyWith(
                //                     fontWeight: FontWeight.w900,
                //                     fontSize: 72,
                //                     letterSpacing: -1,
                //                     height: 0.8,
                //                   ),
                //             )
                //                 .animate(
                //                   delay: const Duration(milliseconds: 4700),
                //                 )
                //                 .blurX(
                //                   begin: 30,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 )
                //                 .slideX(
                //                   begin: 10,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 ),
                //             Text(
                //               "CREATE".toUpperCase(),
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displayLarge
                //                   ?.copyWith(
                //                     fontWeight: FontWeight.w900,
                //                     fontSize: 72,
                //                     letterSpacing: -1,
                //                     height: 0.8,
                //                   ),
                //             )
                //                 .animate(
                //                   delay: const Duration(milliseconds: 4900),
                //                 )
                //                 .blurY(
                //                   begin: 30,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 )
                //                 .slideY(
                //                   begin: 10,
                //                   end: 0,
                //                   duration: const Duration(milliseconds: 300),
                //                   curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //                 ),
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // )
                //     .animate(delay: const Duration(milliseconds: 5500))
                //     .scaleXY(
                //       begin: 1,
                //       end: 0,
                //       duration: const Duration(milliseconds: 400),
                //       curve: Curves.easeOutBack,
                //     )
                //     .blur(
                //       begin: const Offset(0, 0),
                //       end: const Offset(24, 6),
                //       duration: const Duration(milliseconds: 400),
                //       curve: Curves.easeOutBack,
                //     ),

                // Stack(
                //   children: [
                //     Center(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 32,
                //             color: Colors.amber,
                //             strokeAlign: BorderSide.strokeAlignInside,
                //           ),
                //           shape: BoxShape.circle,
                //           color: Colors.white,
                //         ),
                //         width: MediaQuery.of(context).size.width - 120,
                //         height: MediaQuery.of(context).size.width - 120,
                //         child: SizedBox(
                //           width: MediaQuery.of(context).size.width - 120,
                //           height: MediaQuery.of(context).size.width - 120,
                //         ),
                //       )
                //           .animate(delay: const Duration(milliseconds: 5500))
                //           .scaleXY(
                //             begin: 0,
                //             end: 1,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .blur(
                //             begin: const Offset(10, 4),
                //             end: const Offset(0, 0),
                //             duration: const Duration(milliseconds: 400),
                //             curve: Curves.easeOutBack,
                //           )
                //           .then(delay: const Duration(milliseconds: 1800))
                //           .scaleXY(
                //             begin: 1,
                //             end: 1.5,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .then(delay: const Duration(milliseconds: 1000))
                //           .scaleXY(
                //             begin: 1.5,
                //             end: 0,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 400),
                //           ),
                //     ),
                //     Center(
                //       child: Text(
                //         "Logo".toUpperCase(),
                //         style:
                //             Theme.of(context).textTheme.displayLarge?.copyWith(
                //                   fontWeight: FontWeight.w900,
                //                   fontSize: 72,
                //                 ),
                //       )
                //           .animate(delay: const Duration(milliseconds: 5700))
                //           .scaleXY(
                //             begin: 0,
                //             end: 1.2,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .blur(
                //             begin: const Offset(10, 4),
                //             end: const Offset(0, 0),
                //             duration: const Duration(milliseconds: 400),
                //             curve: Curves.easeOutBack,
                //           )
                //           .then(delay: const Duration(milliseconds: 1500))
                //           .blurX(
                //             begin: 0,
                //             end: 30,
                //             duration: const Duration(milliseconds: 400),
                //             curve: Curves.easeOutBack,
                //           )
                //           .slideX(
                //             begin: 0,
                //             end: -4,
                //             duration: const Duration(milliseconds: 400),
                //             curve: Curves.easeOutBack,
                //           ),
                //     ),
                //     Center(
                //       child: Text(
                //         "DESIGN".toUpperCase(),
                //         style:
                //             Theme.of(context).textTheme.displayLarge?.copyWith(
                //                   fontWeight: FontWeight.w900,
                //                   fontSize: 72,
                //                 ),
                //       )
                //           .animate(delay: const Duration(milliseconds: 7500))
                //           .blurX(
                //             begin: 30,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //           )
                //           .slideX(
                //             begin: 4,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.05),
                //           )
                //           .then(delay: const Duration(milliseconds: 1100))
                //           .scaleXY(
                //             begin: 1,
                //             end: 0,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 400),
                //           ),
                //     ),
                //     Center(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 32,
                //             color: Colors.amber,
                //             strokeAlign: BorderSide.strokeAlignInside,
                //           ),
                //           shape: BoxShape.circle,
                //         ),
                //         width: MediaQuery.of(context).size.width - 120,
                //         height: MediaQuery.of(context).size.width - 120,
                //         child: SizedBox(
                //           width: MediaQuery.of(context).size.width - 120,
                //           height: MediaQuery.of(context).size.width - 120,
                //         ),
                //       )
                //           .animate(delay: const Duration(milliseconds: 5500))
                //           .scaleXY(
                //             begin: 0,
                //             end: 1,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 450),
                //           )
                //           .blur(
                //             begin: const Offset(10, 4),
                //             end: const Offset(0, 0),
                //             duration: const Duration(milliseconds: 400),
                //             curve: Curves.easeOutBack,
                //           )
                //           .then(delay: const Duration(milliseconds: 1800))
                //           .scaleXY(
                //             begin: 1,
                //             end: 1.5,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 450),
                //           )
                //           .then(delay: const Duration(milliseconds: 1000))
                //           .scaleXY(
                //             begin: 1.5,
                //             end: 0,
                //             curve: Curves.easeOutBack,
                //             duration: const Duration(milliseconds: 450),
                //           ),
                //     ),
                //   ],
                // ),

                // Stack(
                //   children: [
                //     Container(
                //       color: Colors.amber,
                //     )
                //         .animate(delay: const Duration(milliseconds: 9300))
                //         .scaleX(
                //           begin: 0,
                //           end: 1,
                //           curve: Curves.easeOutBack,
                //           duration: const Duration(milliseconds: 400),
                //         )
                //         .slideX(
                //           begin: 1,
                //           end: 0,
                //           curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           duration: const Duration(milliseconds: 400),
                //         ),
                //     Center(
                //       child: SizedBox(
                //         height: 96,
                //         child: Stack(
                //           children: [
                //             Center(
                //               child: SizedBox(
                //                 height: 48,
                //                 width: 200,
                //                 child: FittedBox(
                //                   fit: BoxFit.fill,
                //                   child: Text(
                //                     "OUTRO".toUpperCase(),
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .displayLarge
                //                         ?.copyWith(
                //                           height: 0.77,
                //                           letterSpacing: -2,
                //                         ),
                //                   ),
                //                 ),
                //               )
                //                   .animate(
                //                       delay: const Duration(milliseconds: 9800))
                //                   .scaleY(
                //                     begin: 0,
                //                     end: 1,
                //                     curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //                     duration: const Duration(milliseconds: 100),
                //                   )
                //                   .then(
                //                       delay: const Duration(milliseconds: 700))
                //                   .slideY(
                //                     begin: 0,
                //                     end: 0.5,
                //                     curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //                     duration: const Duration(milliseconds: 400),
                //                   ),
                //             ),
                //             Center(
                //               child: Container(
                //                 height: 48,
                //                 width: 200,
                //                 color: Colors.amber,
                //                 child: FittedBox(
                //                   fit: BoxFit.fill,
                //                   child: Text(
                //                     "INTRO".toUpperCase(),
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .displayLarge
                //                         ?.copyWith(
                //                           fontWeight: FontWeight.w900,
                //                           height: 0.77,
                //                           letterSpacing: -2,
                //                         ),
                //                   ),
                //                 ),
                //               )
                //                   .animate(
                //                     delay: const Duration(milliseconds: 9300),
                //                   )
                //                   .slideX(
                //                     begin: -10,
                //                     end: 0,
                //                     curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //                     duration: const Duration(milliseconds: 400),
                //                   )
                //                   .blurX(
                //                     begin: 30,
                //                     end: 0,
                //                     duration: const Duration(milliseconds: 400),
                //                     curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //                   )
                //                   .then(
                //                       delay: const Duration(milliseconds: 1000))
                //                   .slideY(
                //                     begin: 0,
                //                     end: -0.5,
                //                     duration: const Duration(milliseconds: 400),
                //                     curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //                   ),
                //             ),
                //           ],
                //         ),
                //       )
                //           .animate(delay: const Duration(milliseconds: 11500))
                //           .slideY(
                //             begin: 0,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           ),
                //     ),
                //     Center(
                //       child: SizedBox(
                //         height: 40,
                //         width: 200,
                //         child: FittedBox(
                //           fit: BoxFit.fill,
                //           child: Text(
                //             "Kinectic".toUpperCase(),
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .displayLarge
                //                 ?.copyWith(
                //                   fontWeight: FontWeight.w900,
                //                   height: 0.77,
                //                   letterSpacing: -2,
                //                   color: Colors.white,
                //                 ),
                //           ),
                //         ),
                //       )
                //           .animate(
                //             delay: const Duration(milliseconds: 11500),
                //           )
                //           .slideY(
                //             begin: 0,
                //             end: 2,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .slideX(
                //             begin: -10,
                //             end: 0,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .blurX(
                //             begin: 30,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           ),
                //     ),
                //     Center(
                //       child: Container(
                //         width: 200,
                //         height: 2,
                //         color: Colors.white,
                //       )
                //           .animate(
                //             delay: const Duration(milliseconds: 11500),
                //           )
                //           .slideY(
                //             begin: 0,
                //             end: 27,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .slideX(
                //             begin: 10,
                //             end: 0,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .blurX(
                //             begin: 30,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           ),
                //     ),
                //     Center(
                //       child: SizedBox(
                //         height: 40,
                //         width: 200,
                //         child: FittedBox(
                //           fit: BoxFit.fill,
                //           child: Text(
                //             "Information".toUpperCase(),
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .displayLarge
                //                 ?.copyWith(
                //                   fontWeight: FontWeight.w900,
                //                   height: 0.77,
                //                   letterSpacing: -2,
                //                   color: Colors.white,
                //                 ),
                //           ),
                //         ),
                //       )
                //           .animate(
                //             delay: const Duration(milliseconds: 11500),
                //           )
                //           .slideY(
                //             begin: 0,
                //             end: -2,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .slideX(
                //             begin: 10,
                //             end: 0,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .blurX(
                //             begin: 30,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           ),
                //     ),
                //     Center(
                //       child: Container(
                //         width: 200,
                //         height: 2,
                //         color: Colors.white,
                //       )
                //           .animate(
                //             delay: const Duration(milliseconds: 11500),
                //           )
                //           .slideY(
                //             begin: 0,
                //             end: -27,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .slideX(
                //             begin: -10,
                //             end: 0,
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //             duration: const Duration(milliseconds: 400),
                //           )
                //           .blurX(
                //             begin: 30,
                //             end: 0,
                //             duration: const Duration(milliseconds: 400),
                //             curve: const Cubic(0.175, 0.885, 0.32, 1.1),
                //           ),
                //     ),
                //   ],
                // ),
              ],
            ),
    );
  }
}
