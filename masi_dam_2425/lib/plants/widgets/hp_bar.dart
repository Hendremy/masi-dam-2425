import 'package:flutter/material.dart';

class HPBar extends StatelessWidget{
  final int currentHP;
  final int maxHP;

  HPBar({
    Key? key,
    required this.currentHP,
    required this.maxHP,
  }) : super(key: key);

  Color _getHPColor() {
    final percentage = currentHP / maxHP;
    if (percentage > 0.5) return Colors.green;
    if (percentage > 0.2) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HP Label and Bar
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4),
                  ),
            child: Row(
              children: [
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  // decoration: BoxDecoration(
                  //   color: Colors.grey[200],
                  //   borderRadius: BorderRadius.circular(4),
                  // ),
                  child: const Text(
                    'HP',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: currentHP / maxHP,
                      backgroundColor: Colors.grey[300],
                      color: _getHPColor(),
                      minHeight: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // HP Numbers
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$currentHP/$maxHP',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    ); 
  } 
}