import 'package:flutter/material.dart';
import 'package:medapp/utils/colors.dart';

class mTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;

  const mTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mSecondaryColorLightOpac),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mSecondaryColor),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class namaOrUmurField extends StatelessWidget {
  final namaOrUmurctrler;
  final String noUHintText;

  const namaOrUmurField({
    super.key,
    required this.namaOrUmurctrler,
    required this.noUHintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: namaOrUmurctrler,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mSecondaryColorLightOpac),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mSecondaryColor),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: noUHintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class jamField extends StatelessWidget {
  final jamfieldController;
  final String? jamFieldHint;

  const jamField({
    super.key,
    required this.jamfieldController,
    required this.jamFieldHint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: jamfieldController,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mSecondaryColorLightOpac),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mSecondaryColor),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: jamFieldHint,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
