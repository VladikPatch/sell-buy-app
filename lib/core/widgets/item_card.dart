import 'package:flutter/material.dart';

import '../../features/buy/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.ownsItem,
    required this.onTap,
  });

  final Item item;
  final bool ownsItem;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.black45, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(item.iconPath, width: 96, height: 96),
                  const SizedBox(height: 16),
                  Text(item.title),
                  Text(item.buyLabel),
                ],
              ),
            ),
            if (ownsItem)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.check_circle, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}
