import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/item.dart';

class ItemsRepository {
  Future<List<Item>> loadItems() async {
    final jsonString = await rootBundle.loadString('assets/data/items.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Item.fromJson(json)).toList();
  }
}
