import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/shop/views/items_gird.dart';

import '../../inventory/cubit/inventory_cubit.dart';
import '../shop_cubit.dart';
import 'filter_bar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();


}

class _ShopPageState extends State<ShopPage> {
  ProductFilter _selectedFilter = ProductFilter.all;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().loadProducts();
  }

  List<ShopItem> _applyFilterAndSearch(List<ShopItem> products) {
    var filteredProducts = _applyFilter(products);
    if (_searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return filteredProducts;
  }

  List<ShopItem> _applyFilter(List<ShopItem> products) {
    switch (_selectedFilter) {
      case ProductFilter.lowToHigh:
        return List.from(products)..sort((a, b) => a.cost.compareTo(b.cost));
      case ProductFilter.highToLow:
        return List.from(products)..sort((a, b) => b.cost.compareTo(a.cost));
      case ProductFilter.all:
      default:
        return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((InventoryCubit cubit) => cubit.state.coins);
    return Scaffold(
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
          const Icon(Icons.monetization_on)
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60), // Height of the search bar
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
        body: Column(
          children: [
            FilterBar(
              selectedFilter: _selectedFilter,
              onFilterChanged: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
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
                    final filteredProducts = _applyFilterAndSearch(state.products);
                    return ItemsGird(items: filteredProducts);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
    );
  }
}