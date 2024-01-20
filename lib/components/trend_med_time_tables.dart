import 'package:flutter/material.dart';
import 'package:medapp/components/all_square_tile/trend_square_tile.dart';

class tTimeTable extends StatelessWidget {
  final String pickHour1;
  final String pickHour2;

  tTimeTable({super.key, required this.pickHour1, required this.pickHour2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TSquareTile(jampick: pickHour1),
          const SizedBox(
            width: 20,
          ),
          TSquareTile(jampick: pickHour2),
        ],
      ),
    );
  }
}
