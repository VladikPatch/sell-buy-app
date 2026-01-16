class Item {
  const Item({
    required this.id,
    required this.iconPath,
    required this.name,
    required this.priceCents,
  });

  final String id;
  final String iconPath;
  final String name;
  final int priceCents;

  Item copyWith({String? id, String? iconPath, String? name, int? priceCents}) {
    return Item(
      id: id ?? this.id,
      iconPath: iconPath ?? this.iconPath,
      name: name ?? this.name,
      priceCents: priceCents ?? this.priceCents,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      iconPath: json['icon_path'] as String,
      name: json['name'] as String,
      priceCents: json['price_cents'] as int,
    );
  }
}
