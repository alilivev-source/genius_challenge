import 'package:flutter/material.dart';
import '../models/player.dart';
import '../storage/game_state.dart';

class HomeScreen extends StatefulWidget {
  final Player player;

  const HomeScreen({super.key, required this.player});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int coins = 200;

  @override
  void initState() {
    super.initState();
    loadCoins();
  }

  void loadCoins() async {
    coins = await GameState.getCoins();
    setState(() {});
  }

  void addCoins() async {
    await GameState.addCoins(10);
    loadCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تحدي العباقرة"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text("💰 $coins"),
            ),
          )
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.player.avatar, style: const TextStyle(fontSize: 70)),
          Text(widget.player.name, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: addCoins,
            child: const Text("تجربة ربح +10 عملات"),
          ),

          const SizedBox(height: 30),

          // أزرار الأقسام (جاهزة للتوسعة)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              category("عامة"),
              category("تاريخ"),
              category("علوم"),
              category("جغرافيا"),
              category("رياضة"),
            ],
          ),
        ],
      ),
    );
  }

  Widget category(String title) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizScreen(title: title),
          ),
        );
      },
      child: Text(title),
    );
  }
}