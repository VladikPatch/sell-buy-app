import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sell_buy_app/models/user.dart';

class UserRepository {
  Future<User> loadUser() async {
    final jsonString = await rootBundle.loadString('assets/data/user.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return User.fromJson(jsonList.first);
  }
}
