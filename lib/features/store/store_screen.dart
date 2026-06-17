import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  int coins = 200;

  final List<String> titles = [

    "العبقري المبتدئ",
    "العبقري السريع",
    "العبقري الذهبي",
    "العبقري الذكي",
    "العبقري الأسطوري",
    "العبقري الخارق",
    "العبقري العبقري",
    "العبقري المتألق",
    "العبقري المحترف",
    "العبقري العظيم",

    // سنضيف البقية لاحقاً
  ];

  String activeTitle = "العبقري المبتدئ";

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  void rewardCoins(int amount) {

    setState(() {
      coins += amount;
    });

    showDialog(
      context: context,

      builder: (_) => AlertDialog(

        title: const Text("مبروك"),

        content: Text(
          "حصلت على $amount عملة",
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },

            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("المتجر"),

        bottom: TabBar(
          controller: _tabController,

          tabs: const [

            Tab(
              text: "العملات",
            ),

            Tab(
              text: "الألقاب",
            ),
          ],
        ),
      ),

      body: TabBarView(

        controller: _tabController,

        children: [

          /// العملات
          ListView(

            padding: const EdgeInsets.all(16),

            children: [

              coinCard(100, 1),

              coinCard(200, 2),

              coinCard(300, 3),
            ],
          ),

          /// الألقاب
          ListView.builder(

            itemCount: titles.length,

            itemBuilder: (_, index) {

              return Card(

                child: ListTile(

                  title: Text(
                    titles[index],
                  ),

                  subtitle: Text(
                    activeTitle == titles[index]
                        ? "مفعل حالياً"
                        : "غير مفعل",
                  ),

                  trailing: ElevatedButton(

                    onPressed: () {

                      setState(() {
                        activeTitle = titles[index];
                      });
                    },

                    child: const Text(
                      "تفعيل",
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget coinCard(int amount, int ads) {

    return Card(

      child: ListTile(

        title: Text(
          "$amount عملة",
        ),

        subtitle: Text(
          "$ads إعلان",
        ),

        trailing: ElevatedButton(

          onPressed: () {

            rewardCoins(amount);
          },

          child: const Text(
            "الحصول",
          ),
        ),
      ),
    );
  }
}