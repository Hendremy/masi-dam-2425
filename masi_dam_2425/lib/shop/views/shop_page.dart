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

  final List<ShopItemType> _itemTypes = [
    ShopItemType.unknown,
    ShopItemType.potion,
    ShopItemType.tools,
    ShopItemType.knowledge,
  ];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().loadProducts();
  }

  List<ShopItem> _applyFilter(List<ShopItem> products) {
    if (_selectedItemType == ShopItemType.unknown) {
      return products; // No filter applied
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
                ..showSnackBar(SnackBar(content: Text('${state.message}')));
            }

            if (state is InventoryMessage) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('${state.message}')));
            }
          },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Shop'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Balance: $wallet',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Icon(Icons.monetization_on),
          ],
        ),
        body: Column(
          children: [
            _buildFilterBar(),
            Expanded(
              child: BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {
                  if (state is ShopLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ShopError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }

                  if (state is ShopLoaded) {
                    final filteredProducts = _applyFilter(state.products);
                    if (filteredProducts.isEmpty) {
                      return const Center(child: Text('No products available.'));
                    }
                    return ItemsGird(items: filteredProducts);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row( // Row to place the text beside the ListView
        children: [
          Text(
            'Filters:',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 100, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _itemTypes.length,
                itemBuilder: (context, index) {
                  final type = _itemTypes[index];
                  final isSelected = _selectedItemType == type;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedItemType = type;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? Colors.blueAccent : Colors.grey.shade50,
                              border: isSelected
                                  ? Border.all(color: Colors.green, width: 3)
                                  : null,
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade300,
                              child: ClipOval(
                                child: ImageLoader(
                                  imageUrl: type.getImageAsset(),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8), 
                          Text(
                            type.name, 
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

  }
}
