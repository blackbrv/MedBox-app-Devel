import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/pages/auth_page.dart';

class JSquareTile extends StatefulWidget {
  static DateTime now = new DateTime.now();
  final String? jampick;
  static String? qrResult;
  JSquareTile({
    super.key,
    this.jampick,
  });

  @override
  State<JSquareTile> createState() => _JSquareTileState();
}

class _JSquareTileState extends State<JSquareTile> {
  int year = JSquareTile.now.year;
  int month = JSquareTile.now.month;
  int day = JSquareTile.now.day;

  final db = FirebaseFirestore.instance;

  static const color1 = Colors.red;
  static const color2 = Colors.green;
  static const greyedColor = Colors.grey;
  var colorChanger = greyedColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: db.collection('profile').doc(AuthPage.x).snapshots().map(
        (value) {
          JSquareTile.qrResult = value.get('kode_alat');
          return null;
        },
      ),
      builder: (context, snapshot) {
        return StreamBuilder<Object>(
            stream: db
                .collection(JSquareTile.qrResult!)
                .doc('${day}-${month}-${year}')
                .snapshots()
                .map(
              (hourData) {
                if (hourData.get('minum_jam${widget.jampick}') == '1') {
                  colorChanger = color2;
                } else if (hourData.get('minum_jam${widget.jampick}') == '0') {
                  colorChanger = color1;
                }
                return {};
              },
            ),
            builder: (context, snapshot) {
              return Container(
                  padding: EdgeInsets.all(20),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(20),
                    color: colorChanger,
                  ),
                  child: textInsideContainer(widget: widget));
            });
      },
    );
  }
}

class textInsideContainer extends StatefulWidget {
  textInsideContainer({
    super.key,
    required this.widget,
  });

  final JSquareTile widget;

  @override
  State<textInsideContainer> createState() => _textInsideContainerState();
}

class _textInsideContainerState extends State<textInsideContainer> {
  String jam = 'No Data';
  int year = JSquareTile.now.year;
  int month = JSquareTile.now.month;
  int day = JSquareTile.now.day;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection(JSquareTile.qrResult!)
            .doc('hour_data_${day}-${month}-${year}')
            .snapshots()
            .map((tcode) {
          return jam = tcode.get('jam${widget.widget.jampick}');
        }),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(
                'Jam ke - ${widget.widget.jampick}',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                '${jam}',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 2),
              ),
            ],
          );
        });
  }
}
