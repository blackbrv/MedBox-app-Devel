import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final String SignInSignUptext;
  final OnTap;
  final btnColors;
  final TTColor;

  const MButton({
    super.key,
    required this.SignInSignUptext,
    required this.btnColors,
    required this.OnTap,
    required this.TTColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: btnColors,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            SignInSignUptext,
            style: TextStyle(
              color: TTColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
