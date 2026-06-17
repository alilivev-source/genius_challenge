import 'dart:math';
import 'package:flutter/material.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen> {

  final List<int> rewards = [
    10,
    20,
    50,
    100,
    0,
    30,
  ];

  int result = 0;

  void spin() {
    final random = Random();
    setState(() {
      result = rewards[random.nextInt(rewards.length)];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ربحت $result عملة")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدولاب"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "النتيجة: $result",
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: spin,
              child: const Text("لف الدولاب"),
            ),
          ],
        ),
      ),
    );
  }
}