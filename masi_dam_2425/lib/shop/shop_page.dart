import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';
import 'package:masi_dam_2425/shop/shop_cubit.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(builder: (context, state) {
      if (state.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        final player = context.read<AvatarCubit>().state.avatar;
        final filteredItems = state.shop?.where((item) {
          return item.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text("Shop"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Balance: ${player?.coins ?? 0}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Icon(Icons.monetization_on),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: filteredItems?.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems?[index];

                    return Card(
                      elevation: 2,
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(item?.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: ${item?.cost ?? 'N/A'}'),
                            Text('Description: ${item?.description ?? 'N/A'}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            context.read<ShopCubit>().buyItem(item!, player!);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
