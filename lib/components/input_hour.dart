import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/components/my_text_field.dart';

class inputJam extends StatelessWidget {
  const inputJam({
    super.key,
    required this.jamcontroller,
    required this.menitcontroller,
    required this.indexHour,
  });

  final TextEditingController jamcontroller;
  final TextEditingController menitcontroller;
  final String indexHour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
        children: [
          Icon(
            Icons.more_time,
            size: 35,
          ),
          const SizedBox(width: 20),
          Text(
            "Jam ke - " + indexHour,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: jamField(
              jamfieldController: jamcontroller,
              jamFieldHint: 'Jam',
            ),
          ),
          Text(
            ":",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: jamField(
              jamfieldController: menitcontroller,
              jamFieldHint: 'Menit',
            ),
          ),
        ],
      ),
    );
  }
}
