import 'package:flutter/material.dart';

class XPBar extends StatelessWidget{
  final int currentXP;
  final int maxXP;

  XPBar({
    Key? key,
    required this.currentXP,
    required this.maxXP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const Text(
        //   'EXP',
        //   style: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: currentXP / maxXP,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    }

}