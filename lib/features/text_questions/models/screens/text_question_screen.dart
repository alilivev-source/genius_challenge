import 'dart:async';

import 'package:flutter/material.dart';

import '../services/question_service.dart';

class TextQuestionScreen extends StatefulWidget {

  const TextQuestionScreen({super.key});

  @override
  State<TextQuestionScreen> createState() =>
      _TextQuestionScreenState();
}

class _TextQuestionScreenState
    extends State<TextQuestionScreen> {

  int currentQuestion = 0;

  int coins = 200;

  int seconds = 25;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {

    timer?.cancel();

    seconds = 25;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        if (seconds == 0) {

          timer.cancel();

          showDialog(
            context: context,

            builder: (_) => AlertDialog(

              title: const Text("انتهى الوقت"),

              content: const Text(
                "إعادة السؤال بإعلان؟",
              ),

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text("لاحقاً"),
                ),
              ],
            ),
          );
        }

        else {

          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  void answerQuestion(int index) {

    final question =
        QuestionService.questions[currentQuestion];

    if (index == question.correctIndex) {

      coins += 10;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "+10 عملات",
          ),
        ),
      );
    }

    nextQuestion();
  }

  void nextQuestion() {

    if (currentQuestion <
        QuestionService.questions.length - 1) {

      setState(() {

        currentQuestion++;

      });

      startTimer();
    }

    else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "انتهت المرحلة",
          ),
        ),
      );
    }
  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final question =
        QuestionService.questions[currentQuestion];

    return Scaffold(

      appBar: AppBar(

        title: Text(
          "العملات: $coins",
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Text(
              "الوقت: $seconds",
              style: const TextStyle(
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              question.question,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(

              child: GridView.builder(

                itemCount:
                    question.answers.length,

                gridDelegate:

                    const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,

                  crossAxisSpacing: 10,

                  mainAxisSpacing: 10,
                ),

                itemBuilder: (_, index) {

                  return ElevatedButton(

                    onPressed: () {

                      answerQuestion(index);
                    },

                    child: Text(
                      question.answers[index],
                    ),
                  );
                },
              ),
            ),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

              children: [

                ElevatedButton(
                  onPressed: () {},

                  child: const Text(
                    "تخطي",
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},

                  child: const Text(
                    "صديق",
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},

                  child: const Text(
                    "حذف 2",
                  ),
                ),

                ElevatedButton(
                  onPressed: () {

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(

                      SnackBar(
                        content: Text(
                          question.hint,
                        ),
                      ),
                    );
                  },

                  child: const Text(
                    "تلميح",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}