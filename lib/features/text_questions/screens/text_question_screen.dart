import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

import '../services/question_service.dart';
import '../../player/services/player_service.dart';
import '../services/ad_service.dart';

class TextQuestionScreen extends StatefulWidget {
  const TextQuestionScreen({super.key});

  @override
  State<TextQuestionScreen> => _TextQuestionScreenState();
}

class _TextQuestionScreenState
    extends State<TextQuestionScreen> with TickerProviderStateMixin {

  int currentQuestion = 0;
  int coins = 200;
  int seconds = 25;
  Timer? timer;

  List<int> hiddenAnswers = [];
  Map<int, AnimationController> _controllers = {};

  int? selectedAnswer;
  bool answered = false;
  bool fiftyFiftyUsed = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

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
          nextQuestion();
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  Future<void> _playSound(bool isCorrect) async {
    // صوت نجاح او خطأ
    final sound = isCorrect? 'correct.mp3' : 'wrong.mp3';
    await _audioPlayer.play(AssetSource(sound));

    // اهتزاز
    if (await Vibration.hasVibrator()?? false) {
      if (isCorrect) {
        Vibration.vibrate(duration: 100);
      } else {
        Vibration.vibrate(duration: 300, amplitude: 255);
      }
    }
  }

  void answerQuestion(int index) async {
    if (answered) return; // منع الضغط مرتين

    timer?.cancel();
    setState(() {
      answered = true;
      selectedAnswer = index;
    });

    final question = QuestionService.questions[currentQuestion];
    bool isCorrect = index == question.correctIndex;

    await _playSound(isCorrect);

    if (isCorrect) {
      setState(() {
        coins += 10;
      });
      await PlayerService.addCoins(10);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("+10 عملات"), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("إجابة خاطئة"), backgroundColor: Colors.red),
      );
    }

    await Future.delayed(const Duration(milliseconds: 1200));
    nextQuestion();
  }

  void nextQuestion() {
    if (currentQuestion < QuestionService.questions.length - 1) {
      setState(() {
        currentQuestion++;
        hiddenAnswers.clear();
        _controllers.forEach((_, c) => c.dispose());
        _controllers.clear();
        answered = false;
        selectedAnswer = null;
        fiftyFiftyUsed = false;
      });

      startTimer();
    } else {
      Navigator.pop(context);
    }
  }

  void skipQuestion() {
    timer?.cancel();
    nextQuestion();
  }

  void showHint() {
    final question = QuestionService.questions[currentQuestion];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(question.hint)),
    );
  }

  // 👥 اسأل صديق
  void askFriend() {
    final question = QuestionService.questions[currentQuestion];

    AdService.showRewardedAd(() {
      Share.share(question.question);
    });
  }

  // ❌❌ حذف إجابتين - نسخة محمية + انيميشن 500ms
  void removeTwoAnswers() {
    if (fiftyFiftyUsed || answered) return; // مرة وحدة بس

    final question = QuestionService.questions[currentQuestion];

    AdService.showRewardedAd(() {
      setState(() {
        fiftyFiftyUsed = true;
        hiddenAnswers.clear();

        List<int> wrongAnswers = [];
        for (int i = 0; i < question.answers.length; i++) {
          if (i!= question.correctIndex) {
            wrongAnswers.add(i);
          }
        }

        wrongAnswers.shuffle();

        // حماية إذا أقل من 2 إجابة غلط
        if (wrongAnswers.length >= 2) {
          hiddenAnswers.add(wrongAnswers[0]);
          hiddenAnswers.add(wrongAnswers[1]);
        } else if (wrongAnswers.isNotEmpty) {
          hiddenAnswers.add(wrongAnswers[0]);
        }

        for (var idx in hiddenAnswers) {
          _controllers[idx] = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 500),
          )..forward();
        }
      });
    });
  }

  Color _getAnswerColor(int index) {
    if (!answered) return Colors.blue;
    if (index == QuestionService.questions[currentQuestion].correctIndex) {
      return Colors.green;
    }
    if (index == selectedAnswer) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  void dispose() {
    timer?.cancel();
    _controllers.forEach((_, c) => c.dispose());
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = QuestionService.questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text("💰 $coins"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "الوقت: $seconds",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            Text(
              question.question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: question.answers.length,
                itemBuilder: (_, index) {
                  if (hiddenAnswers.contains(index)) {
                    final controller = _controllers[index];
                    if (controller == null) return const SizedBox.shrink();

                    return AnimatedBuilder(
                      animation: controller,
                      builder: (_, child) {
                        return Opacity(
                          opacity: 1 - controller.value,
                          child: Transform.translate(
                            offset: Offset(-200 * controller.value, 0),
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(question.answers[index]),
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getAnswerColor(index),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: answered? null : () => answerQuestion(index),
                      child: Text(question.answers[index]),
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: answered? null : skipQuestion,
                  child: const Text("تخطي"),
                ),
                ElevatedButton(
                  onPressed: answered? null : showHint,
                  child: const Text("تلميح"),
                ),
                ElevatedButton(
                  onPressed: answered? null : askFriend,
                  child: const Text("صديق"),
                ),
                ElevatedButton(
                  onPressed: (answered || fiftyFiftyUsed)? null : removeTwoAnswers,
                  child: Text(fiftyFiftyUsed? "تم الحذف" : "حذف 2"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}