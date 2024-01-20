import 'package:flutter/material.dart';
import 'package:medapp/components/doctor_component/doctor_square_tile.dart';

class dTimeTable extends StatelessWidget {
  final String pickHour1;
  final String pickHour2;

  const dTimeTable(
      {super.key, required this.pickHour1, required this.pickHour2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dSquareTile(jampick: pickHour1),
          const SizedBox(
            width: 20,
          ),
          dSquareTile(jampick: pickHour2),
        ],
      ),
    );
  }
}
