import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

import '../../inventory/cubit/inventory_cubit.dart';

class ItemCard extends StatelessWidget {
  final ShopItem product;

  const ItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((InventoryCubit cubit) => cubit.state.coins);
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              children: [

                Expanded(
                  flex: 2, // Flex to balance image with text
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                  ),
                  ),
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.cost.toStringAsFixed(2)}',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: wallet >= product.cost
                        ? () {
                      context.read<InventoryCubit>().add(product);
                    }
                        : null,
                    color:
                    wallet >= product.cost ? Colors.green : Colors.grey,
                  ),
                  )]
                )));

  }
}