import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/common/image_loader.dart';

import '../../inventory/cubit/inventory_cubit.dart';
import '../../common/item_details.dart';

class ItemCard extends StatelessWidget {
  final ShopItem product;

  const ItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((InventoryCubit cubit) => cubit.state.coins);
    
    return InkWell(
      onTap: () => _showDetails(context, product, wallet),
      splashColor: Colors.green,
      child: Card(
        elevation: Theme.of(context).cardTheme.elevation,
        color: Theme.of(context).cardTheme.color,
        margin: Theme.of(context).cardTheme.margin,
        shape: Theme.of(context).cardTheme.shape,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ImageLoader(imageUrl: product.image, width: 100, height: 100)
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.cost.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, ShopItem product, int wallet) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        final buyAction = ElevatedButton(
          onPressed: wallet >= product.cost
              ? () {
            context.read<InventoryCubit>().add(product);
            Navigator.pop(context); // Close the popup
          }
              : null,
          child: Text(wallet >= product.cost
              ? 'Purchase'
              : 'Insufficient Funds'),
        );
        return ItemDetails(
          product: product,
          action: buyAction,
        );
      },
    );
  }
}