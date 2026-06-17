import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإنجازات"),
      ),
      body: ListView(
        children: const [

          ListTile(
            leading: Icon(Icons.star),
            title: Text("أول إجابة صحيحة"),
            subtitle: Text("افتح أول سؤال"),
          ),

          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text("جامع العملات"),
            subtitle: Text("احصل على 1000 عملة"),
          ),

          ListTile(
            leading: Icon(Icons.flash_on),
            title: Text("سريع جدًا"),
            subtitle: Text("أجب 10 أسئلة بدون خطأ"),
          ),

        ],
      ),
    );
  }
}