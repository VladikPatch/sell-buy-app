import 'dart:math';

import 'package:sell_buy_app/features/buy/item.dart';

final random = new Random();

int randomPriceInRange(int minCents, int maxCents) {
  return minCents + random.nextInt(maxCents - minCents + 1);
}

final List<Item> items = [
  Item(
    typeId: 'croissant',
    title: 'Croissant',
    buyCents: randomPriceInRange(199, 399),
    sellCents: randomPriceInRange(199, 399),
    iconPath: 'assets/icons/croissant.png',
  ),
  Item(
    typeId: 'coffee',
    title: 'Coffee',
    buyCents: randomPriceInRange(99, 249),
    sellCents: randomPriceInRange(99, 249),
    iconPath: 'assets/icons/coffee.png',
  ),
  Item(
    typeId: 'french fries',
    title: 'French fries',
    buyCents: randomPriceInRange(199, 599),
    sellCents: randomPriceInRange(199, 599),
    iconPath: 'assets/icons/french-fries.png',
  ),
  Item(
    typeId: 'salad',
    title: 'Salad',
    buyCents: randomPriceInRange(299, 699),
    sellCents: randomPriceInRange(299, 699),
    iconPath: 'assets/icons/salad.png',
  ),
];
