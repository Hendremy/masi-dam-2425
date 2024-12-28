import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/inventory/cubit/inventory_cubit.dart';
import 'package:masi_dam_2425/common/item_details.dart';

import '../../model/shop_item.dart';

class InventoryPage extends StatelessWidget{

  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Inventory'),
      ),
      body: BlocListener<InventoryCubit, InventoryState>(
        listener: (context, state) {
          if (state is InventoryUpdated) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
          }
        },
        child: BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
            if (state is InventoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is InventoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Retry loading the inventory when error occurs
                        context.read<InventoryCubit>().loadInventory();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is InventoryLoaded) {
              return ListView(
                children: state.inventory.items.entries.map((entry) {
                  return buildInventoryItem(entry.key, entry.value, context);
                }).toList(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildInventoryItem(ShopItem item, bool isSelected, BuildContext context) {

    return InkWell(
        onTap: () {
          _showDetails(context, item, isSelected);
        },
      splashColor: Colors.green,
      child: Card(
        elevation: 4,
        color: !isSelected ? Colors.green[100] : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image, scale: 1.0),
            radius: 30,
            ),
          title: Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const SizedBox(height: 8),
              Text(
                'Type: ${item.type.name}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'Buffer: ${item.buffValue}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // Ensures it only takes as much space as needed
            children: [
              // Text next to the Switch
              Text(
                isSelected ? 'Equipped' : 'Equip',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8), // Space between text and switch
              Switch(
                value: isSelected,
                onChanged: (value) {
                  context.read<InventoryCubit>().toggleItem(item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, ShopItem product, bool isSelected) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        final equipUnequip = Row(
          mainAxisSize: MainAxisSize.min, // Ensures it only takes as much space as needed
          children: [
            // Text next to the Switch
            Text(
              isSelected ? 'Equipped' : 'Equip',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8), // Space between text and switch
            Switch(
              value: isSelected,
              onChanged: (value) {
                Navigator.pop(context);
                context.read<InventoryCubit>().toggleItem(product);
              },
            ),
          ],
        );
       return ItemDetails(product: product, action: equipUnequip);
      },
    );
  }

}