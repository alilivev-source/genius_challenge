import 'dart:math';
import 'package:flutter/material.dart';

class ImageQuestionScreen extends StatefulWidget {
  const ImageQuestionScreen({super.key});

  @override
  State<ImageQuestionScreen> createState() => _ImageQuestionScreenState();
}

class _ImageQuestionScreenState extends State<ImageQuestionScreen> {
  final List<Map<String, String>> questions = [
    {
      "image": "assets/images/questions/apple.png",
      "answer": "تفاح",
    },
    {
      "image": "assets/images/questions/car.png",
      "answer": "سيارة",
    },
    {
      "image": "assets/images/questions/phone.png",
      "answer": "هاتف",
    },
  ];

  int index = 0;
  List<String> userAnswer = [];
  List<String> letters = [];

  @override
  void initState() {
    super.initState();
    loadQuestion();
  }

  void loadQuestion() {
    userAnswer.clear();

    String answer = questions[index]["answer"]!;
    letters = answer.split("");

    // إضافة حروف عشوائية
    List<String> randomLetters =
        List.generate(6, (_) => String.fromCharCode(65 + Random().nextInt(26)));

    letters.addAll(randomLetters);
    letters.shuffle();

    setState(() {});
  }

  void selectLetter(String letter) {
    setState(() {
      userAnswer.add(letter);
      letters.remove(letter);
    });

    checkAnswer();
  }

  void checkAnswer() {
    String correct = questions[index]["answer"]!;
    if (userAnswer.join() == correct) {
      Future.delayed(const Duration(milliseconds: 500), () {
        nextQuestion();
      });
    }
  }

  void nextQuestion() {
    if (index < questions.length - 1) {
      index++;
      loadQuestion();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("انتهت الأسئلة")),
      );
    }
  }

  void removeLetter() {
    if (userAnswer.isNotEmpty) {
      setState(() {
        String removed = userAnswer.removeLast();
        letters.add(removed);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String image = questions[index]["image"]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("أسئلة الصور"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Image.asset(
            image,
            height: 200,
          ),

          const SizedBox(height: 20),

          Wrap(
            children: userAnswer
                .map((e) => Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Text(e),
                    ))
                .toList(),
          ),

          const SizedBox(height: 20),

          Wrap(
            children: letters.map((letter) {
              return GestureDetector(
                onTap: () => selectLetter(letter),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue.shade100,
                  child: Text(letter),
                ),
              );
            }).toList(),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: nextQuestion,
                child: const Text("تخطي"),
              ),
              ElevatedButton(
                onPressed: removeLetter,
                child: const Text("حذف حرف"),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}