import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

final userProvider = AsyncNotifierProvider<UserNotifier, User>(() {
  return UserNotifier();
});

class UserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    final repository = ref.read(userRepositoryProvider);
    return await repository.loadUser();
  }

  void buy(List<Item> items, int totalPrice) {
    final currentUser = state.value;
    if (currentUser == null) return;

    final newBalance = currentUser.balanceCents - totalPrice;
    final currentInventory = Map<String, int>.from(currentUser.inventory);

    for (Item item in items) {
      currentInventory.update(item.id, (count) => count + 1, ifAbsent: () => 1);
    }

    state = AsyncValue.data(
      currentUser.copyWith(
        balanceCents: newBalance,
        inventory: currentInventory,
      ),
    );
  }

  void sell(List<Item> items, int totalPrice) {
    final currentUser = state.value;
    if (currentUser == null) return;

    final newBalance = currentUser.balanceCents + totalPrice;
    final currentInventory = Map<String, int>.from(currentUser.inventory);

    for (Item item in items) {
      final currentCount = currentUser.inventory[item.id] ?? 0;

      if (currentCount == 1) {
        currentInventory.remove(item.id);
      } else {
        currentInventory[item.id] = currentCount - 1;
      }
    }

    state = AsyncValue.data(
      currentUser.copyWith(
        balanceCents: newBalance,
        inventory: currentInventory,
      ),
    );
  }
}
