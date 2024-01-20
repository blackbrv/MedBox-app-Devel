import 'package:flutter/material.dart';
import 'package:medapp/components/all_square_tile/jadwal_square_tile.dart';

class medTimeTable extends StatelessWidget {
  final String pickHour1;
  final String pickHour2;
  const medTimeTable(
      {super.key, required this.pickHour1, required this.pickHour2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          JSquareTile(jampick: pickHour1),
          const SizedBox(
            width: 20,
          ),
          JSquareTile(jampick: pickHour2),
        ],
      ),
    );
  }
}
