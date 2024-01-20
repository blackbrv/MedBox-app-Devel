import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/pages/doctor/trend_lansia/doctor_trend_lansia_page.dart';

class dSquareTile extends StatefulWidget {
  final String? jampick;
  static String? tdate, tmonth, tyear, qrResult, doctorFinalDateSq;
  const dSquareTile({super.key, this.jampick});

  @override
  State<dSquareTile> createState() => _dSquareTileState();
}

class _dSquareTileState extends State<dSquareTile> {
  final db = FirebaseFirestore.instance;

  static const color1 = Colors.red;
  static const color2 = Colors.green;
  static const greyedColor = Colors.grey;
  var colorChanger = greyedColor;

  @override
  void didChangeDependencies() {
    dSquareTile.tdate = dTrend.doctordate;
    dSquareTile.tmonth = dTrend.doctormonth;
    dSquareTile.tyear = dTrend.doctoryear;
    dSquareTile.qrResult = dTrend.unicCode;
    dSquareTile.doctorFinalDateSq =
        '${dSquareTile.tdate}-${dSquareTile.tmonth}-${dSquareTile.tyear}';

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: db
          .collection(dSquareTile.qrResult!)
          .doc(dSquareTile.doctorFinalDateSq)
          .snapshots()
          .map((hourData) {
        if (hourData.get('minum_jam${widget.jampick}') == '1') {
          colorChanger = color2;
        } else if (hourData.get('minum_jam${widget.jampick}') == '0') {
          colorChanger = color1;
        }
        return null;
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return StatefulBuilder(builder: (context, myStateFunc) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(20),
                color: colorChanger,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 0),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: textInsideContainer(widget: widget),
            );
          });
        } else {
          return Container();
        }
      },
    );
  }
}

class textInsideContainer extends StatefulWidget {
  const textInsideContainer({
    super.key,
    required this.widget,
  });

  final dSquareTile widget;

  @override
  State<textInsideContainer> createState() => _textInsideContainerState();
}

class _textInsideContainerState extends State<textInsideContainer> {
  String jam = 'No Data';
  String? containerYear = dSquareTile.tdate;
  String? containerMonth = dSquareTile.tmonth;
  String? containerDate = dSquareTile.tyear;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: FirebaseFirestore.instance
          .collection(dSquareTile.qrResult!)
          .doc('hour_data_$containerYear-$containerMonth-$containerDate')
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
