import 'dart:isolate';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/EmptyWidget.dart';
import 'package:flutter_animation_practice/FiveWordsAnimation.dart';
import 'package:flutter_animation_practice/FlowAnimator.dart';
import 'package:flutter_animation_practice/FourWordsAnimation.dart';
import 'package:flutter_animation_practice/ImageGlassParallaxEffect.dart';
import 'package:flutter_animation_practice/OneWordAnimation.dart';
import 'package:flutter_animation_practice/CutoutAnimations.dart';
import 'package:flutter_animation_practice/RevealAnimations.dart';
import 'package:flutter_animation_practice/ThreeWordsAnimation.dart';
import 'package:flutter_animation_practice/TwoWordsAnimation.dart';
import 'package:flutter_animation_practice/models/AnimationModel.dart';
import 'package:flutter_animation_practice/models/AnimatorModel.dart';
import 'package:flutter_animation_practice/presentations/ImageSlidePresentation.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter_animation_practice/utils/dart_image.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          useMaterial3: true),
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

  bool initializeCompleted = false;

  final List<Widget> animationWidgets = [];

  final constantPhrases = [
    [
      "With",
      "Great".toUpperCase(),
      "Power",
      "Comes",
      "Great",
      "Responsibilities",
    ],
    ["SEAMLESS"],
    ["Your"],
    ["Business"],
    ["Motion Graphics"],
    ["CREATE"],
    ["DESIGN"],
    ["INFORMATION"],
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

  final List<String> oneWordsPhrases = [
    'Evolve'.toUpperCase(),
    'Inspire'.toUpperCase(),
    'Create'.toUpperCase(),
    'Thrive'.toUpperCase(),
    'Dream'.toUpperCase(),
    'Unite'.toUpperCase(),
  ];
  final List<String> twoWordsPhrases = [
    'Just breathe'.toUpperCase(),
    'Stay curious'.toUpperCase(),
    'Embrace change'.toUpperCase(),
    'Dream big'.toUpperCase(),
    'Choose joy'.toUpperCase(),
  ];
  final List<String> threeWordsPhrases = [
    'Stay true always'.toUpperCase(),
    'Love conquers all'.toUpperCase(),
    'Seek the adventure'.toUpperCase(),
    'Be the change'.toUpperCase(),
    'Act with purpose'.toUpperCase(),
  ];
  final List<String> fourWordsPhrases = [
    'Believe in yourself, always'.toUpperCase(),
    'Live, laugh, love deeply'.toUpperCase(),
    'Chase your wildest dreams'.toUpperCase(),
    'Happiness is a journey'.toUpperCase(),
    'Knowledge is true power'.toUpperCase(),
  ];
  final List<String> fiveWordsPhrases = [
    'Every day is a-new beginning'.toUpperCase(),
    'The-best is yet to come'.toUpperCase(),
    'Change is the only constant'.toUpperCase(),
    'Success is-a journey, not destination'.toUpperCase(),
    'Every moment is a fresh start'.toUpperCase(),
  ];
  final List<String> dynamicLengthPhrases = [
    'Believe you can, and you\'re halfway there'.toUpperCase(),
    'The only way to do great work is to love what you do'.toUpperCase(),
    'Success is not final, failure is not fatal, It is the courage to continue that counts'
        .toUpperCase(),
    'Your limitation it’s only your imagination'.toUpperCase(),
    'Dream it. Wish it. Do it.'.toUpperCase(),
    'Great things never come from comfort zones'.toUpperCase(),
    'Don\'t watch the clock do what it does Keep going'.toUpperCase(),
  ];

  late List<List<String>> phrases = [];

  late List<ui.Image> cacheImage = [];

  Random random = Random();

  int _flowAnimatorIndex = 0;

  late final List<AnimatorModel> _animatorList = List.generate(
    10,
    (index) {
      return AnimatorModel(
        startPageAnimation: const RevealAnimation(
          delayInMilli: 0,
          durationInMilli: 400,
          type: Reveals.sideHorizontal,
        ),
        startBackgroundAnimation: const RevealAnimation(
          delayInMilli: 200,
          durationInMilli: 400,
          type: Reveals.bottomRightCircular,
        ),
        startForegroundAnimation: const CutoutAnimation(
          delayInMilli: 700,
          durationInMilli: 400,
          type: Cutouts.centerHorizontal,
        ),
        // startForegroundAnimation: const RevealAnimation(
        //   delayInMilli: 700,
        //   durationInMilli: 400,
        //   type: Reveals.centerVertical,
        // ),
        endForegroundAnimation: const CutoutAnimation(
          delayInMilli: 200,
          durationInMilli: 400,
          type: Cutouts.centerHorizontal,
        ),
        // endForegroundAnimation: const RevealAnimation(
        //   delayInMilli: 400,
        //   durationInMilli: 400,
        //   type: Reveals.sideHorizontal,
        // ),
        endBackgroundAnimation: const CutoutAnimation(
          delayInMilli: 1700,
          durationInMilli: 4800,
          type: Cutouts.centerHorizontal,
        ),
        // endBackgroundAnimation: const RevealAnimation(
        //   delayInMilli: 1700,
        //   durationInMilli: 800,
        //   type: Reveals.bottomRightCircular,
        // ),
        endPageAnimation: const RevealAnimation(
          delayInMilli: 2700,
          durationInMilli: 400,
          type: Reveals.sideHorizontal,
        ),
        backgroundWidget: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: RawImage(
            image: index % 3 == 0
                ? cacheImage[0]
                : (index % 2 == 0 ? cacheImage[1] : cacheImage[2]),
            fit: BoxFit.cover,
            scale: 1.2,
          ),
        ),
        foregroundWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Hello'.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();
    initializePhrases();
    initCachedImage();
  }

  void initializePhrases() {
    phrases = constantPhrases.toList();
  }

  void initCachedImage() async {
    for (int i = 0; i < 6; i++) {
      // We cannot use rootBundle in Isolate due to it has native binding and native binding cannot be spawned from isolates
      final ByteData assetImageByteData =
          await rootBundle.load("assets/images/image${i + 1}.jpg");

      final encodeImage = await compute((assetImageByteData) async {
        final uiImage = await getUiImage(
          assetImageByteData,
          1024,
          1024,
        );
        final encodeImage = image.encodeJpg(uiImage);
        return encodeImage;
      }, assetImageByteData);

      // encoding can only be done on the main thread :')
      ui.Codec codec =
          await ui.instantiateImageCodec(encodeImage, allowUpscaling: false);
      ui.FrameInfo frameInfo = await codec.getNextFrame();

      cacheImage.add(frameInfo.image);
    }

    setState(() {
      initializeCompleted = true;
    });
  }

  void initiateAnimations() {
    animationWidgets.add(
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
                                onExitAnimation: () {
                                  setState(() {
                                    startAnimation = false;
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
          });
        },
      ),
    );
  }

  void randomAnimation() async {
    if (phrases.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
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

  void nextFlowAnimatorWidget() {
    animationWidgets.add(
      ImageSlidePresentation(
        phrases:
            dynamicLengthPhrases[Random().nextInt(dynamicLengthPhrases.length)]
                .toUpperCase()
                .split(' '),
        images: cacheImage,
        onExitAnimationStarted: () async {
          await Future.delayed(const Duration(milliseconds: 800));
          startAnimation = false;
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );

    // animationWidgets
    //     .add(getFlowAnimatorWidget(_animatorList[_flowAnimatorIndex]));
    // if (mounted) {
    //   setState(() {});
    // }
  }

  Widget getFlowAnimatorWidget(AnimatorModel model) {
    return FlowAnimator(
      animatorModel: model,
      onExitAnimation: () async {
        _flowAnimatorIndex++;
        if (_animatorList.length == _flowAnimatorIndex) {
          _flowAnimatorIndex = 0;
          await Future.delayed(const Duration(milliseconds: 500));
          startAnimation = false;
          if (mounted) {
            setState(() {});
          }
          return;
        }

        nextFlowAnimatorWidget();
      },
    );
  }

  bool isOutXAxis = false;

  Widget getAnimationWidget(List<String> phrase) {
    // reveal animation
    // return TextRevealAnimtaion(
    //   text: phrase[0],
    //   key: ValueKey(phrase[0]),
    //   onExitAnimation: () {
    //     randomAnimation();
    //   },
    // );

    // cutout animation
    // return TextCutoutAnimtaion(
    //   text: phrase[0],
    //   key: ValueKey(phrase[0]),
    //   onExitAnimation: () {
    //     randomAnimation();
    //   },
    // );

    // imagees animation
    // bool lastOutXAxis = isOutXAxis;
    // final outAxis = Random().nextInt(2) == 0
    //     ? ImageParallaxAnimAxis.X
    //     : ImageParallaxAnimAxis.Y;
    // isOutXAxis = outAxis == ImageParallaxAnimAxis.X;
    // return ImageParallaxEffectAnimation(
    //   background: cacheImage[random.nextInt(6)],
    //   // bgImage: "assets/images/image${random.nextInt(6) + 1}.jpg",
    //   inAxis: lastOutXAxis ? ImageParallaxAnimAxis.X : ImageParallaxAnimAxis.Y,
    //   outAxis: outAxis,
    //   onExitAnimation: () {
    //     randomAnimation();
    //   },
    // );

    // multiple text animations
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
      // floatingActionButton: Row(
      //   children: [
      //     const Expanded(child: SizedBox()),
      //     FloatingActionButton.extended(
      //       icon: Icon(startAnimation ? Icons.stop : Icons.play_arrow),
      //       label: Text(initializeCompleted ? "Flow Animation" : "Loading.."),
      //       onPressed: !initializeCompleted
      //           ? null
      //           : () {
      //               setState(() {
      //                 _flowAnimatorIndex = 0;
      //                 animationWidgets.clear();
      //                 startAnimation = !startAnimation;

      //                 if (startAnimation) {
      //                   nextFlowAnimatorWidget();
      //                 }
      //               });
      //             },
      //     ),
      //     const Expanded(child: SizedBox()),
      //     FloatingActionButton.extended(
      //       icon: Icon(startAnimation ? Icons.stop : Icons.play_arrow),
      //       label: Text(initializeCompleted ? "Random Animation" : "Loading.."),
      //       onPressed: !initializeCompleted
      //           ? null
      //           : () {
      //               setState(() {
      //                 _flowAnimatorIndex = 0;
      //                 animationWidgets.clear();
      //                 startAnimation = !startAnimation;

      //                 if (startAnimation) {
      //                   initializePhrases();
      //                   randomAnimation();
      //                 }
      //               });
      //             },
      //     ),
      //     const Expanded(child: SizedBox()),
      //     FloatingActionButton.extended(
      //       icon: Icon(startAnimation ? Icons.stop : Icons.play_arrow),
      //       label: const Text("Animation"),
      //       onPressed: () {
      //         setState(() {
      //           _flowAnimatorIndex = 0;
      //           animationWidgets.clear();
      //           startAnimation = !startAnimation;

      //           if (startAnimation) {
      //             initiateAnimations();
      //           }
      //         });
      //       },
      //     ),
      //   ],
      // ),
      body: !initializeCompleted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    "Images Preloading\n in memory",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : !startAnimation
              ? EmptyWidget(
                  backgroundImagePressed: () {
                    setState(() {
                      _flowAnimatorIndex = 0;
                      animationWidgets.clear();
                      startAnimation = !startAnimation;

                      if (startAnimation) {
                        nextFlowAnimatorWidget();
                      }
                    });
                  },
                  kineticAnimationPressed: () {
                    setState(() {
                      _flowAnimatorIndex = 0;
                      animationWidgets.clear();
                      startAnimation = !startAnimation;

                      if (startAnimation) {
                        initiateAnimations();
                      }
                    });
                  },
                  oneWordAnimationExample: () {
                    startOneWordAnimation();
                  },
                  twoWordAnimationExample: () {
                    startTwoWordAnimation();
                  },
                  threeWordAnimationExample: () {
                    startThreeWordAnimation();
                  },
                  fourWordAnimationExample: () {
                    startFourWordAnimation();
                  },
                  fiveWordAnimationExample: () {
                    startFiveWordAnimation();
                  },
                  revealAnimationExample: () {
                    startRevealAnimation();
                  },
                  cutoutAnimationExample: () {
                    startCutoutAnimation();
                  },
                )
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

  void startOneWordAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        animationWidgets.add(
          OneWordAnimation(
            oneWordsPhrases[Random().nextInt(oneWordsPhrases.length)],
            onExitAnimation: () {
              setState(() {
                animationWidgets.add(
                  OneWordAnimation(
                    oneWordsPhrases[Random().nextInt(oneWordsPhrases.length)],
                    onExitAnimation: () {
                      setState(() {
                        animationWidgets.add(
                          OneWordAnimation(
                            oneWordsPhrases[
                                Random().nextInt(oneWordsPhrases.length)],
                            onExitAnimation: () {
                              setState(() {
                                animationWidgets.add(
                                  OneWordAnimation(
                                    oneWordsPhrases[Random()
                                        .nextInt(oneWordsPhrases.length)],
                                    onExitAnimation: () {
                                      setState(() {
                                        animationWidgets.add(
                                          OneWordAnimation(
                                            oneWordsPhrases[Random().nextInt(
                                                oneWordsPhrases.length)],
                                            onExitAnimation: () {
                                              setState(() {
                                                startAnimation = false;
                                              });
                                            },
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                );
                              });
                            },
                          ),
                        );
                      });
                    },
                  ),
                );
              });
            },
          ),
        );
      }
    });
  }

  void startTwoWordAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        final words = twoWordsPhrases[Random().nextInt(twoWordsPhrases.length)]
            .split(' ');

        animationWidgets.add(
          TwoWordsAnimation(
            words[0],
            words[1],
            onExitAnimation: () {
              setState(() {
                final words =
                    twoWordsPhrases[Random().nextInt(twoWordsPhrases.length)]
                        .split(' ');
                animationWidgets.add(
                  TwoWordsAnimation(
                    words[0],
                    words[1],
                    onExitAnimation: () {
                      setState(() {
                        startAnimation = false;
                      });
                    },
                  ),
                );
              });
            },
          ),
        );
      }
    });
  }

  void startThreeWordAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        final words =
            threeWordsPhrases[Random().nextInt(threeWordsPhrases.length)]
                .split(' ');

        animationWidgets.add(
          ThreeWordsAnimation(
            words[0],
            words[1],
            words[2],
            onExitAnimation: () {
              setState(() {
                final words = threeWordsPhrases[
                        Random().nextInt(threeWordsPhrases.length)]
                    .split(' ');
                animationWidgets.add(
                  ThreeWordsAnimation(
                    words[0],
                    words[1],
                    words[2],
                    onExitAnimation: () {
                      setState(() {
                        startAnimation = false;
                      });
                    },
                  ),
                );
              });
            },
          ),
        );
      }
    });
  }

  void startFourWordAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        final words =
            fourWordsPhrases[Random().nextInt(fourWordsPhrases.length)]
                .split(' ');

        animationWidgets.add(
          FourWordsAnimation(
            words[0],
            words[1],
            words[2],
            words[3],
            onExitAnimation: () {
              setState(() {
                final words =
                    fourWordsPhrases[Random().nextInt(fourWordsPhrases.length)]
                        .split(' ');
                animationWidgets.add(
                  FourWordsAnimation(
                    words[0],
                    words[1],
                    words[2],
                    words[3],
                    onExitAnimation: () {
                      setState(() {
                        startAnimation = false;
                      });
                    },
                  ),
                );
              });
            },
          ),
        );
      }
    });
  }

  void startFiveWordAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        final words =
            fiveWordsPhrases[Random().nextInt(fiveWordsPhrases.length)]
                .split(' ');

        animationWidgets.add(
          FiveWordsAnimation(
            words[0],
            words[1],
            words[2],
            words[3],
            words[4],
            onExitAnimation: () {
              setState(() {
                final words =
                    fiveWordsPhrases[Random().nextInt(fiveWordsPhrases.length)]
                        .split(' ');
                animationWidgets.add(
                  FiveWordsAnimation(
                    words[0],
                    words[1],
                    words[2],
                    words[3],
                    words[4],
                    onExitAnimation: () {
                      setState(() {
                        startAnimation = false;
                      });
                    },
                  ),
                );
              });
            },
          ),
        );
      }
    });
  }

  void startRevealAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        final words =
            dynamicLengthPhrases[Random().nextInt(fiveWordsPhrases.length)]
                .split(' ');
        const index = 0;

        animationWidgets.add(
          TextRevealAnimtaion(
            text: words[index],
            key: ValueKey(const Uuid().v4()),
            onExitAnimation: () {
              iterateRevealAnimation(words, index + 1);
            },
          ),
        );
      }
    });
  }

  void iterateRevealAnimation(List<String> words, int currentIndex) {
    setState(() {
      if (currentIndex == words.length) {
        startAnimation = false;
        return;
      }
      animationWidgets.add(
        TextRevealAnimtaion(
          text: words[currentIndex],
          key: ValueKey(const Uuid().v4()),
          onExitAnimation: () {
            iterateRevealAnimation(
              words,
              currentIndex + 1,
            );
          },
        ),
      );
    });
  }

  void startCutoutAnimation() {
    setState(() {
      _flowAnimatorIndex = 0;
      animationWidgets.clear();
      startAnimation = !startAnimation;

      if (startAnimation) {
        final words =
            dynamicLengthPhrases[Random().nextInt(fiveWordsPhrases.length)]
                .split(' ');
        const index = 0;

        animationWidgets.add(
          TextCutoutAnimtaion(
            text: words[index],
            key: ValueKey(const Uuid().v4()),
            onExitAnimation: () {
              iterateCutoutAnimation(words, index + 1);
            },
          ),
        );
      }
    });
  }

  void iterateCutoutAnimation(List<String> words, int currentIndex) {
    setState(() {
      if (currentIndex == words.length) {
        startAnimation = false;
        return;
      }
      animationWidgets.add(
        TextCutoutAnimtaion(
          text: words[currentIndex],
          key: ValueKey(const Uuid().v4()),
          onExitAnimation: () {
            iterateCutoutAnimation(
              words,
              currentIndex + 1,
            );
          },
        ),
      );
    });
  }
}
