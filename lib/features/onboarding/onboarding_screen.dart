import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final TextEditingController nameController = TextEditingController();

  int selectedAvatar = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء الملف الشخصي"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                labelText: "اسم اللاعب",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "اختر صورة رمزية",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 80,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,

                itemBuilder: (context, index) {

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar = index;
                      });
                    },

                    child: Container(
                      margin: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        border: Border.all(
                          color: selectedAvatar == index
                              ? Colors.blue
                              : Colors.grey,
                          width: 3,
                        ),
                      ),

                      child: CircleAvatar(
                        radius: 30,
                        child: Text("${index + 1}"),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },

              child: const Text(
                "ابدأ اللعب",
              ),
            ),
          ],
        ),
      ),
    );
  }
}