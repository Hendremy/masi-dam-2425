import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
            ),
            const SizedBox(height: 8),
            Text(
              'ID: ${item.id}',
            ),
            const SizedBox(height: 8),
            Text(
              'Type: ${item.type.toString().split('.').last}',
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${item.description}',
            ),
            const SizedBox(height: 8),
            Text(
              'Equipped: ${item.isEquipped ? 'Yes' : 'No'}',
            ),
            const SizedBox(height: 8),
            Text(
              'Cost: ${item.cost}',
            ),
          ],
        ),
      ),
    );
  }
}