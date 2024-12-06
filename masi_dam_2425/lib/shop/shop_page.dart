import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';
import 'package:masi_dam_2425/shop/shop_cubit.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String searchQuery = '';
  String sortOrder = 'asc';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Shop'),
              backgroundColor: Colors.green,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final player = context.read<AvatarCubit>().state.avatar;
          var filteredItems = state.shop?.where((item) {
            return item.name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

          if (sortOrder == 'asc') {
            filteredItems?.sort((a, b) => a.cost.compareTo(b.cost));
          } else {
            filteredItems?.sort((a, b) => b.cost.compareTo(a.cost));
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Shop'),
              backgroundColor: Colors.green,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Balance: ${player?.coins ?? 0}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const Icon(Icons.monetization_on)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (query) {
                            setState(() {
                              searchQuery = query;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            hintText: 'Search items...',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                       Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButton<String>(
                          value: sortOrder,
                          icon: const Icon(Icons.sort),
                          onChanged: (String? newValue) {
                            setState(() {
                              sortOrder = newValue!;
                            });
                          },
                          isDense: true,
                          underline: Container(), // Remove underline
                          items: <String>['asc', 'desc']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  const Text('Cost '),
                                  Icon(
                                    value == 'asc'
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: filteredItems?.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems?[index];
                        final isAffordable = player?.canBuy(item!);
                        return ItemCardWidget(item: item, isAffordable: isAffordable, player: player);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.item,
    required this.isAffordable,
    required this.player,
  });

  final ShopItem? item;
  final dynamic isAffordable;
  final Avatar? player;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10)),
              child: item?.image != null
                  ? Image.asset(
                      item!.image,
                      fit: BoxFit.contain,
                    )
                  : Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.green,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    item?.name ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Price: ${item?.cost ?? "N/A"}'),
                const SizedBox(height: 4),
                Text(
                  item?.description ?? 'N/A',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: isAffordable
                  ? () {
                      context
                          .read<ShopCubit>()
                          .buyItem(item!, player!);
                    }
                  : null,
              color:
                  isAffordable ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
