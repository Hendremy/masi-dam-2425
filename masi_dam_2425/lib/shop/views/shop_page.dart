import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/common/image_loader.dart';
import 'package:masi_dam_2425/shop/views/items_gird.dart';

import '../../inventory/cubit/inventory_cubit.dart';
import '../shop_cubit.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  ShopItemType _selectedItemType = ShopItemType.unknown;

  List<ShopItemType> itemTypes = [
    ShopItemType.unknown,
    ShopItemType.potion,
    ShopItemType.tools,
    ShopItemType.knowledge
  ];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().loadProducts();
  }

  List<ShopItem> _applyFilter(List<ShopItem> products) {
    if (_selectedItemType == ShopItemType.unknown) {
      return products;
    }
    return products.where((product) => product.type == _selectedItemType).toList();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((InventoryCubit cubit) => cubit.state.coins);

    return BlocListener<InventoryCubit, InventoryState>(
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
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Balance: ${wallet}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const Icon(Icons.monetization_on),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80), // Height for the filter row
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.blueGrey.shade200,
            child: SizedBox(
              height: 50, // Height of the row of asset images
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemTypes.length,
                itemBuilder: (context, index) {
                  String assetName = itemTypes[index].getImageAsset();
                  bool isSelected = _selectedItemType == itemTypes[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedItemType = itemTypes[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Colors.blueAccent : Colors.grey.shade50, // Highlight color
                          border: isSelected
                              ? Border.all(color: Colors.green, width: 3) // Add border for selected item
                              : null,
                        ),
                        // Use a CircleAvatar to display the image (or icon
                        child: CircleAvatar(
                          radius: 30, // Set radius to control the size of the circle
                          backgroundColor: Colors.grey.shade300,
                          child: ClipOval(
                            child: ImageLoader(imageUrl: assetName, width: 50, height: 50)
                          ),
                        ),
                      )
                      ),
                    );
                },
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Optionally use the FilterBar if needed for other filters

          Expanded(
            child: BlocBuilder<ShopCubit, ShopState>(
              builder: (context, state) {
                if (state is ShopLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ShopLoaded && state.products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                if (state is ShopError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                if (state is ShopLoaded) {
                  // Apply the filter based on the selected item type
                  final filteredProducts = _applyFilter(state.products);
                  return ItemsGird(items: filteredProducts);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    ));
  }
}