import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/inventory/cubit/inventory_cubit.dart';
import 'package:masi_dam_2425/common/item_details.dart';
import '../../model/shop_item.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is InventoryUpdated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('${state.message}')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Inventory'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
            if (state is InventoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is InventoryLoaded && state.inventory.items.isEmpty) {
              return const Center(child: Text('No items in your inventory'));
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
                        context.read<InventoryCubit>().loadInventory();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is InventoryLoaded) {
              return ListView.builder(
                itemCount: state.inventory.items.length,
                itemBuilder: (context, index) {
                  final entry = state.inventory.items.entries.elementAt(index);
                  return _buildInventoryItem(entry.key, entry.value, context);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInventoryItem(ShopItem item, bool isSelected, BuildContext context) {
    return Card(
      elevation: 4,
      color: isSelected ? Colors.white : Colors.green[100],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.image),
          radius: 30,
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('Type: ${item.type.name}\nBuffer: ${item.buffValue}'),
        trailing: Switch(
          value: isSelected,
          onChanged: (value) {
            context.read<InventoryCubit>().toggleItem(item);
          },
        ),
        onTap: () {
          _showDetails(context, item, isSelected);
        },
      ),
    );
  }

  void _showDetails(BuildContext context, ShopItem item, bool isSelected) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return ItemDetails(
          product: item,
          action: Switch(
            value: isSelected,
            onChanged: (value) {
              Navigator.pop(context);
              context.read<InventoryCubit>().toggleItem(item);
            },
          ),
        );
      },
    );
  }
}
