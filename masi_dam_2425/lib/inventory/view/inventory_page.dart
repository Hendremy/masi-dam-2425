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
            ..showSnackBar(SnackBar(content: Text(state.message)));
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
            } else if (state is InventoryError) {
              return _buildErrorState(context, state);
            } else if (state is InventoryLoaded) {
              return state.inventory.items.isEmpty
                  ? const Center(child: Text('No items in your inventory'))
                  : _buildInventoryList(state.inventory.items, context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, InventoryError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
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

  Widget _buildInventoryList(
      Map<ShopItem, bool> items, BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final entry = items.entries.elementAt(index);
        return _buildInventoryItem(entry.key, entry.value, context);
      },
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
            _onToggleItem(context, item);
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
              _onToggleItem(context, item);
            },
          ),
        );
      },
    );
  }

  void _onToggleItem(BuildContext context, ShopItem item) {
    final cubit = context.read<InventoryCubit>();
    if (cubit.state is InventoryLoaded) {
      cubit.toggleItem(item);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot toggle items while loading')),
      );
    }
  }
}