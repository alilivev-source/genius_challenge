import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الصدارة"),
      ),
      body: ListView(
        children: const [

          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text("1 - اللاعب الأول"),
            subtitle: Text("9999 نقطة"),
          ),

          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text("2 - اللاعب الثاني"),
            subtitle: Text("8500 نقطة"),
          ),

          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text("3 - اللاعب الثالث"),
            subtitle: Text("7000 نقطة"),
          ),

        ],
      ),
    );
  }
}