import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

class ItemDetails extends StatelessWidget {

  final ShopItem product;
  final Widget action;

  const ItemDetails({
    super.key,
    required this.product,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image and Name Section
              Container(
                padding: const EdgeInsets.all(8),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${product.cost.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Buff and Description Section
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.green,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Buff: ${product.buffValue}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              action,
            ],
          ),
        );
  }

}