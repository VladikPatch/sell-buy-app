import '../../features/buy/item.dart';

class UserData {
  const UserData({
    this.balanceCents = 2000,
    this.ownedCountsByTypeId = const {},
  });

  final int balanceCents;
  final Map<String, int> ownedCountsByTypeId;

  String get formattedBalance => '\$${(balanceCents / 100).toStringAsFixed(2)}';

  UserData copyWith({
    int? balanceCents,
    Map<String, int>? ownedCountsByTypeId,
  }) => UserData(
    balanceCents: balanceCents ?? this.balanceCents,
    ownedCountsByTypeId: ownedCountsByTypeId ?? this.ownedCountsByTypeId,
  );
}
