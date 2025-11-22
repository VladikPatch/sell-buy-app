import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item.dart';
import 'items_data.dart';

final displayItemsProvider = Provider.family<List<Item>, String>((ref, viewId) {
  final shuffled = List<Item>.from(items)..shuffle(Random());
  return shuffled
      .take(4)
      .map((item) => item.duplicate())
      .toList(growable: false);
});
