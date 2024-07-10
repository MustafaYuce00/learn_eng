import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learn_eng/data/a1.dart';
import 'package:learn_eng/data/a2.dart';
import 'package:learn_eng/data/b1.dart';
import 'package:learn_eng/data/b2.dart';
import 'package:learn_eng/models/soruModel.dart';
import 'package:learn_eng/screens/homeScreen.dart';

// anlık toplam 4453 soru var

// ignore: must_be_immutable
class TestScreen extends StatefulWidget {
  TestScreen({super.key, required this.data});
  // ignore: prefer_typing_uninitialized_variables
  var data;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  CountDownController timerController = CountDownController();
  Random random = Random();
  List<Soru>? sorular;
  int dogruCevap = 0;
  int yanlisCevap = 0;
  int comboCount = 0;

  int currentQuestionIndex = 0;
  late List<String> shuffledOptions;

  @override
  void initState() {
    super.initState();
    if (widget.data["name"] == "A1") {
      sorular = A1List.a1Sorular;
    } else if (widget.data["name"] == "A2") {
      sorular = A2List.a2Sorular;
    } else if (widget.data["name"] == "B1") {
      sorular = B1List.b1Sorular;
    } else if (widget.data["name"] == "B2") {
      sorular = B2List.b2Sorular;
    }
    /* else if (widget.data["name"] == "C1") {
      sorular = C1List.c1Sorular;
    } else if (widget.data["name"] == "C2") {
      sorular = C2List.c2Sorular;
    }*/

    currentQuestionIndex = random.nextInt(sorular!.length);
    shuffleOptions();
  }

  void shuffleOptions() {
    shuffledOptions = List.from(sorular![currentQuestionIndex].secenekler!);
    shuffledOptions.shuffle();
  }

  void checkAnswer(
    String selectedAnswer,
  ) {
    if (selectedAnswer == sorular![currentQuestionIndex].dogruCevap!) {
      //! doğru cevap verildiğinde
      setState(() {
        currentQuestionIndex = random.nextInt(sorular!.length);
        shuffleOptions();
        comboCount++;
        dogruCevap++;
        if (comboCount >= 5) {
          //! 5 combo yapınca süreye 5 saniye ekler
          setState(() {
            var currentDuration = timerController.getTime();
            timerController.restart(
              duration: int.tryParse(currentDuration!)! + 5,
            );
          });
        }
      });
    } else {
      //! yanlış cevap verildiğinde
      setState(() {
        comboCount = 0;
        yanlisCevap++;
      });
      // Yanlış cevap, verdiğini bildirme işlemi üstbildirim ile yapılabilir
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              animation: AnimationController(
                vsync: this,
                duration: const Duration(seconds: 1),
              ),
              content: Column(
                children: [
                  Text('Yanlış Cevap: $selectedAnswer'),
                  Text(
                      'Doğru Cevap: ${sorular![currentQuestionIndex].dogruCevap}'),
                ],
              ),
              duration: const Duration(milliseconds: 1500),
            ),
          )
          .closed
          .then((reason) {
        setState(() {
          currentQuestionIndex = random.nextInt(sorular!.length);
          shuffleOptions();
        });
      });

      // Yanlış cevap, istenilen işlemi yapabilirsiniz.
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data["name"]! + widget.data["description"]!),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  //! Combo count and timer
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Combo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < 5; i++)
                                i < comboCount
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      )
                                    : Icon(
                                        Icons.circle,
                                        color: Colors.grey,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      CircularCountDownTimer(
                        duration: 30,
                        initialDuration: 0,
                        controller: timerController,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        ringColor: Colors.grey[300]!,
                        ringGradient: null,
                        fillColor: Colors.purpleAccent[100]!,
                        fillGradient: null,
                        backgroundColor: Colors.purple[500],
                        backgroundGradient: null,
                        strokeWidth: 20.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: true,
                        isTimerTextShown: true,
                        autoStart: true,
                        onStart: () {
                          debugPrint('Countdown Started');
                        },
                        onComplete: () {
                          debugPrint('Countdown Ended');
                          // süre bittiğinde yapılacak işlemler
                          // ignore: void_checks
                          return ShowAlertDialog(context);
                        },
                        onChange: (String timeStamp) {
                          debugPrint('Countdown Changed $timeStamp');
                        },
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            return "0";
                          } else {
                            return Function.apply(
                                defaultFormatterFunction, [duration]);
                          }
                        },
                      ),
                    ],
                  ),
                  //! animation quastions
                  questions(
                    context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column questions(BuildContext context) {
    return Column(
      children: [
        // soru
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              sorular![currentQuestionIndex].soruMetni!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // cevaplar
        Column(
          children: [
            for (var i = 0; i < 4; i++)
              GestureDetector(
                onTap: () {
                  checkAnswer(shuffledOptions[i]);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      shuffledOptions[i],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fade().scale(),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  ShowAlertDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Süre Bitti'),
            content:
                Text('Doğru Cevap: $dogruCevap\nYanlış Cevap: $yanlisCevap'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }), (route) => false);
                },
                child: const Text('Anasayfaya Dön'),
              ),
              /*  TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    timerController.restart(duration: 10);
                  },
                  child: const Text('Evet'),
                ),*/
            ],
          ),
        );
      },
    );
  }
}
