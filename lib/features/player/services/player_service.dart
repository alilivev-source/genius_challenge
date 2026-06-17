import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/player_model.dart';

class PlayerService {

  static const String _key = "player_data";

  static Future<PlayerModel> getPlayer() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_key);

    if (data == null) {
      final player = PlayerModel.defaultPlayer();
      await savePlayer(player);
      return player;
    }

    return PlayerModel.fromJson(jsonDecode(data));
  }

  static Future<void> savePlayer(PlayerModel player) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(player.toJson()));
  }

  static Future<PlayerModel> addCoins(int amount) async {
    final player = await getPlayer();

    final updated = player.copyWith(
      coins: player.coins + amount,
    );

    await savePlayer(updated);
    return updated;
  }

  static Future<PlayerModel> removeCoins(int amount) async {
    final player = await getPlayer();

    final updated = player.copyWith(
      coins: (player.coins - amount).clamp(0, 999999),
    );

    await savePlayer(updated);
    return updated;
  }

  static Future<PlayerModel> addScore(int amount) async {
    final player = await getPlayer();

    final updated = player.copyWith(
      score: player.score + amount,
    );

    await savePlayer(updated);
    return updated;
  }

  static Future<PlayerModel> levelUp() async {
    final player = await getPlayer();

    final updated = player.copyWith(
      level: player.level + 1,
    );

    await savePlayer(updated);
    return updated;
  }

  static Future<PlayerModel> addAchievement() async {
    final player = await getPlayer();

    final updated = player.copyWith(
      achievementsCount: player.achievementsCount + 1,
    );

    await savePlayer(updated);
    return updated;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}