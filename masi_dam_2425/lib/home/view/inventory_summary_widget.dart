import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/inventory/cubit/inventory_cubit.dart';

class InventorySummaryWidget extends StatelessWidget {

  final VoidCallback onShopTap; // Callback for navigating to the shop
  final VoidCallback onInventoryTap; // Callback for navigating to the inventory

  const InventorySummaryWidget({
    super.key,
    required this.onShopTap,
    required this.onInventoryTap,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        if (state is InventoryLoading) {
          return _buildInventoryLoading();
        }

        if (state is InventoryLoaded) {
          return _buildInventorySummary(onShopTap: onShopTap, onInventoryTap: onInventoryTap, state: state);
        }

        if (state is InventoryError) {
          return Center(
            child: Text(state.message),
          );
        }

        return const SizedBox.shrink();

      },
    );

  }
}

class _buildInventoryLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Inventory',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildInventorySummary extends StatelessWidget {

  final VoidCallback onShopTap; // Callback for navigating to the shop
  final VoidCallback onInventoryTap; // Callback for navigating to the inventory
  final InventoryState state;

  const _buildInventorySummary({
    super.key,
    required this.onShopTap,
    required this.onInventoryTap,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {

    final equippedItems = state.equippedItems;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Inventory',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            equippedItems.isEmpty
                ? Center(
              child: Text(
                'No items equipped',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
                : SizedBox(
              height: 50, // Adjust height to fit your item size
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: equippedItems.length,
                itemBuilder: (context, index) {
                  final assetPath = equippedItems[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    // Use a CircleAvatar to display the image (or icon
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),

                      child: Image.asset(
                        assetPath,
                        fit: BoxFit.contain,
                        width: 40,
                        height: 40,
                      ),
                    ));

                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: onShopTap,
                  icon: const Icon(Icons.store),
                  label: const Text('Shop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: onInventoryTap,
                  icon: const Icon(Icons.inventory),
                  label: const Text('More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}