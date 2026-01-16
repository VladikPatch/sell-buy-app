class User {
  const User({
    required this.id,
    required this.displayName,
    required this.balanceCents,
    required this.inventory,
  });

  final String id;
  final String displayName;
  final int balanceCents;
  final Map<String, int> inventory;

  User copyWith({
    String? id,
    String? displayName,
    int? balanceCents,
    Map<String, int>? inventory,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      balanceCents: balanceCents ?? this.balanceCents,
      inventory: inventory ?? this.inventory,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      displayName: json['display_name'] as String,
      balanceCents: json['balance_cents'] as int,
      inventory: Map<String, int>.from(json['inventory'] ?? {}),
    );
  }
}
