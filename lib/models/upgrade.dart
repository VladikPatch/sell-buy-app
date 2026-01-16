import '../constants/enums.dart';

class Upgrade {
  Upgrade({
    required this.id,
    required this.iconPath,
    required this.name,
    required this.type,
    required this.priceCents,
  });

  final String id;
  final String iconPath;
  final String name;
  final UpgradeType type;
  final int priceCents;

  factory Upgrade.fromJson(Map<String, dynamic> json) {
    return Upgrade(
      id: json['id'] as String,
      iconPath: json['iconPath'] as String,
      name: json['name'] as String,
      type: _parseType(json['type'] as String?),
      priceCents: json['priceCents'] as int,
    );
  }

  static _parseType(String? type) {
    switch (type) {
      case 'new_item':
        return UpgradeType.newItem;
      case 'sell_increase':
        return UpgradeType.sellIncrease;
      case 'buy_decrease':
        return UpgradeType.buyDecrease;
      default:
        return UpgradeType.unknown;
    }
  }
}

class UpgradesGroup {
  UpgradesGroup({
    required this.id,
    required this.cycleLevel,
    required this.upgradeA,
    required this.upgradeB,
  });

  final String id;
  final int cycleLevel;
  final Upgrade upgradeA;
  final Upgrade upgradeB;

  factory UpgradesGroup.fromJson(Map<String, dynamic> json) {
    return UpgradesGroup(
      id: json['id'] as String,
      cycleLevel: json['cycle_level'] as int,
      upgradeA: Upgrade.fromJson(json['upgrade_a'] as Map<String, dynamic>),
      upgradeB: Upgrade.fromJson(json['upgrade_b'] as Map<String, dynamic>),
    );
  }
}
