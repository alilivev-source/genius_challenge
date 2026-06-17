import 'package:flutter/material.dart';

import '../text_questions/screens/text_question_screen.dart';
import '../store/store_screen.dart';
import '../wheel/wheel_screen.dart';
import '../leaderboard/leaderboard_screen.dart';

import '../player/models/player_model.dart';
import '../player/services/player_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PlayerModel player = PlayerModel.defaultPlayer();

  @override
  void initState() {
    super.initState();
    loadPlayer();
  }

  /// 🔄 تحميل بيانات اللاعب من الذاكرة
  void loadPlayer() async {
    final data = await PlayerService.getPlayer();

    setState(() {
      player = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تحدي العباقرة"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const SizedBox(height: 20),

            /// 👤 بطاقة اللاعب الحقيقي
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),

                title: Text(player.name),

                subtitle: Text(player.title),

                trailing: Text("💰 ${player.coins}"),
              ),
            ),

            const SizedBox(height: 30),

            /// 🎮 بدء اللعب
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () async {

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const TextQuestionScreen(),
                    ),
                  );

                  /// 🔄 بعد الرجوع يحدث البيانات
                  loadPlayer();
                },
                child: const Text("ابدأ التحدي"),
              ),
            ),

            const SizedBox(height: 15),

            /// 🏪 المتجر
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const StoreScreen(),
                    ),
                  );
                },
                child: const Text("المتجر"),
              ),
            ),

            const SizedBox(height: 15),

            /// 🎡 الدولاب
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const WheelScreen(),
                    ),
                  );
                },
                child: const Text("الدولاب"),
              ),
            ),

            const SizedBox(height: 15),

            /// 🏆 الصدارة
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const LeaderboardScreen(),
                    ),
                  );
                },
                child: const Text("الصدارة"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}