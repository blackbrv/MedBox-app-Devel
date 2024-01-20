import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/pages/trend_jadwal/user_trend_page.dart';

class TSquareTile extends StatefulWidget {
  final String? jampick;
  static String? qrResult, tdate, tmonth, tyear;

  const TSquareTile({super.key, this.jampick});

  @override
  State<TSquareTile> createState() => _TSquareTileState();
}

class _TSquareTileState extends State<TSquareTile> {
  final db = FirebaseFirestore.instance;

  static const color1 = Colors.red;
  static const color2 = Colors.green;
  static const greyedColor = Colors.grey;
  var colorChanger = greyedColor;

  @override
  void didChangeDependencies() {
    TSquareTile.tdate = usrTrendPage.Date;
    TSquareTile.tmonth = usrTrendPage.Month;
    TSquareTile.tyear = usrTrendPage.Year;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: db.collection('profile').doc(AuthPage.x).snapshots().map(
        (value) {
          TSquareTile.qrResult = value.get('kode_alat');
          return null;
        },
      ),
      builder: (context, snapshot) {
        return StreamBuilder<Object>(
          stream: db
              .collection(TSquareTile.qrResult!)
              .doc(
                  '${TSquareTile.tdate}-${TSquareTile.tmonth}-${TSquareTile.tyear}')
              .snapshots()
              .map(
            (hourData) {
              if (hourData.get('minum_jam${widget.jampick}') == '1') {
                colorChanger = color2;
              } else if (hourData.get('minum_jam${widget.jampick}') == '0') {
                colorChanger = color1;
              }
              setState(() {});
              return {};
            },
          ),
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(20),
                color: colorChanger,
              ),
              child: textInsideContainer(widget: widget),
            );
          },
        );
      },
    );
  }
}

class textInsideContainer extends StatefulWidget {
  textInsideContainer({
    super.key,
    required this.widget,
  });

  final TSquareTile widget;

  @override
  State<textInsideContainer> createState() => _textInsideContainerState();
}

class _textInsideContainerState extends State<textInsideContainer> {
  String jam = 'No Data';
  String? containerYear = TSquareTile.tdate;
  String? containerMonth = TSquareTile.tmonth;
  String? containerDate = TSquareTile.tyear;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: FirebaseFirestore.instance
          .collection(TSquareTile.qrResult!)
          .doc('hour_data_$containerYear}-$containerMonth-$containerDate')
          .snapshots()
          .map((tcode) {
        return jam = tcode.get('jam${widget.widget.jampick}');
      }),
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
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
              jam,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 2),
            ),
          ],
        );
      },
    );
  }
}
