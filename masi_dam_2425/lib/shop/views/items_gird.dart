import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/shop/views/item_card.dart';

class ItemsGird extends StatelessWidget {
  final List<ShopItem> items;

  const ItemsGird({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemCard(product: items[index]);
      },
    );
  }
}