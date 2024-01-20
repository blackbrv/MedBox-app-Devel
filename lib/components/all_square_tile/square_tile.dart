import 'package:flutter/material.dart';
import 'package:medapp/utils/colors.dart';

class SquareTile extends StatelessWidget {
  final imagePath;
  final colorPicky;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.colorPicky,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: mGreyColor),
        borderRadius: BorderRadius.circular(16),
        color: colorPicky,
      ),
      child: Image.asset(
        imagePath,
        height: 180,
      ),
    );
  }
}
