import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sell_buy_app/models/upgrade.dart';

class UpgradesRepository {
  Future<List<UpgradesGroup>> loadUpgrades() async {
    final jsonString = await rootBundle.loadString('assets/data/upgrades.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UpgradesGroup.fromJson(json)).toList();
  }
}
