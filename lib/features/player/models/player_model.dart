class PlayerModel {

  final String name;

  final int coins;

  final int level;

  final int score;

  final String title;

  final int achievementsCount;

  final int wheelSpinsToday;

  final DateTime? lastWheelSpin;

  PlayerModel({
    required this.name,
    required this.coins,
    required this.level,
    required this.score,
    required this.title,
    required this.achievementsCount,
    required this.wheelSpinsToday,
    this.lastWheelSpin,
  });

  PlayerModel copyWith({
    String? name,
    int? coins,
    int? level,
    int? score,
    String? title,
    int? achievementsCount,
    int? wheelSpinsToday,
    DateTime? lastWheelSpin,
  }) {

    return PlayerModel(
      name: name ?? this.name,
      coins: coins ?? this.coins,
      level: level ?? this.level,
      score: score ?? this.score,
      title: title ?? this.title,
      achievementsCount:
          achievementsCount ?? this.achievementsCount,
      wheelSpinsToday:
          wheelSpinsToday ?? this.wheelSpinsToday,
      lastWheelSpin:
          lastWheelSpin ?? this.lastWheelSpin,
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'name': name,

      'coins': coins,

      'level': level,

      'score': score,

      'title': title,

      'achievementsCount':
          achievementsCount,

      'wheelSpinsToday':
          wheelSpinsToday,

      'lastWheelSpin':
          lastWheelSpin?.toIso8601String(),
    };
  }

  factory PlayerModel.fromJson(
      Map<String, dynamic> json) {

    return PlayerModel(

      name: json['name'] ?? 'لاعب',

      coins: json['coins'] ?? 200,

      level: json['level'] ?? 1,

      score: json['score'] ?? 0,

      title:
          json['title'] ?? 'العبقري المبتدئ',

      achievementsCount:
          json['achievementsCount'] ?? 0,

      wheelSpinsToday:
          json['wheelSpinsToday'] ?? 0,

      lastWheelSpin:
          json['lastWheelSpin'] != null
              ? DateTime.parse(
                  json['lastWheelSpin'],
                )
              : null,
    );
  }

  factory PlayerModel.defaultPlayer() {

    return PlayerModel(

      name: 'لاعب',

      coins: 200,

      level: 1,

      score: 0,

      title: 'العبقري المبتدئ',

      achievementsCount: 0,

      wheelSpinsToday: 0,

      lastWheelSpin: null,
    );
  }
}