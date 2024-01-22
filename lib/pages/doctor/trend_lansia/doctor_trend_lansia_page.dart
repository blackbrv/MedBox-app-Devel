import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/components/doctor_component/doctor_trend_time_table.dart';
import 'package:table_calendar/table_calendar.dart';

class dTrend extends StatefulWidget {
  static String? doctordate, doctormonth, doctoryear, doctorfinalDate, unicCode;
  final String? qrcode, namaLan;
  dTrend({super.key, this.qrcode, this.namaLan});

  @override
  State<dTrend> createState() => _dTrendState();
}

class _dTrendState extends State<dTrend> {
  DateTime doctortoday = DateTime.now();
  static DateTime now = DateTime.now();
  int day = now.day;
  int month = now.month;
  int year = now.year;
  String doctorDay = '${now.day}-${now.month}-${now.year}';

  void topbackbtn() {
    Navigator.pop(context);
  }

  void _onDaySelected(DateTime yad, DateTime focusedDay) {
    setState(() {
      doctortoday = yad;
      dTrend.doctordate = doctortoday.day.toString();
      dTrend.doctormonth = doctortoday.month.toString();
      dTrend.doctoryear = doctortoday.year.toString();
      dTrend.doctorfinalDate =
          '${dTrend.doctordate}-${dTrend.doctormonth}-${dTrend.doctoryear}';
      doctorDay = dTrend.doctorfinalDate!;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                newRoute(widget: widget, doctorDay: doctorDay)));
  }

  @override
  void initState() {
    print(doctortoday);
    print('doctor trend lansia page ${widget.qrcode}');
    setState(() {
      dTrend.unicCode = widget.qrcode;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Trend Lansia Minum Obat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                'Silahkan Pilih Tanggal Untuk\nMelihat Trend Lansia ${widget.namaLan} Minum Obat',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: mWhiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    rowHeight: 65,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                        defaultTextStyle: TextStyle(color: mSecondaryColor),
                        weekendTextStyle:
                            TextStyle(color: mSecondaryColorLightOpac),
                        outsideTextStyle:
                            TextStyle(color: mSecondaryColorLightesOpac),
                        selectedDecoration: BoxDecoration(
                            color: mSecondaryColor, shape: BoxShape.circle),
                        todayTextStyle: TextStyle(color: mAccentColor),
                        todayDecoration: BoxDecoration(
                            color: mSecondaryColorDarkerLightOpac,
                            shape: BoxShape.circle)),
                    availableGestures: AvailableGestures.all,
                    focusedDay: doctortoday,
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2040, 1, 1),
                    selectedDayPredicate: (day) => isSameDay(day, doctortoday),
                    onDaySelected: _onDaySelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class newRoute extends StatefulWidget {
  const newRoute({
    super.key,
    required this.widget,
    required this.doctorDay,
  });

  final dTrend widget;
  final String doctorDay;

  @override
  State<newRoute> createState() => _newRouteState();
}

class _newRouteState extends State<newRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Lansia : ${widget.widget.namaLan}',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.93,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: mWhiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Data Tanggal ${widget.doctorDay}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.red,
                          ),
                          Text(' = Tidak Minum Obat'),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.green,
                          ),
                          Text(' = Sudah Minum Obat'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.grey,
                          ),
                          Text(' = Tidak Ada Data'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const dTimeTable(pickHour1: '1', pickHour2: '2'),
                      const dTimeTable(pickHour1: '3', pickHour2: '4'),
                      const dTimeTable(pickHour1: '5', pickHour2: '6'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
