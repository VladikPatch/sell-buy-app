import 'package:riverpod/riverpod.dart';
import 'package:sell_buy_app/core/user/user_data.dart';

import '../../features/buy/item.dart';

final userProvider = NotifierProvider<UserProvider, UserData>(UserProvider.new);

class UserProvider extends Notifier<UserData> {
  @override
  UserData build() =>
      const UserData(balanceCents: 2000, ownedCountsByTypeId: {});

  void buy(Item item) {
    if (state.balanceCents < item.buyCents) ; // No money

    final updatedCounts = Map<String, int>.from(state.ownedCountsByTypeId);

    updatedCounts.update(item.typeId, (count) => count + 1, ifAbsent: () => 1);

    state = state.copyWith(
      balanceCents: state.balanceCents - item.buyCents,
      ownedCountsByTypeId: updatedCounts,
    );
  }

  // void sell(Item item) {
  //   final newInventory = List<Item>.from(state.inventory);
  //   final newOwnedIds = Set<String>.from(state.ownedIds);
  //
  //   final index = newInventory.indexWhere(
  //     (inventoryItem) => inventoryItem.id == item.id,
  //   );
  //
  //   if (index == -1) return; // No money
  //
  //   newInventory.removeAt(index);
  //   newOwnedIds.remove(item.id);
  //
  //   state = state.copyWith(
  //     balanceCents: state.balanceCents + item.sellCents,
  //     inventory: newInventory,
  //     ownedIds: newOwnedIds,
  //   );
  // }
}
