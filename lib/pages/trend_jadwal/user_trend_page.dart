import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/components/trend_med_time_tables.dart';
import 'package:medapp/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class usrTrendPage extends StatefulWidget {
  static String? Date, Month, Year, finalDate;
  const usrTrendPage({super.key});

  @override
  State<usrTrendPage> createState() => _usrTrendPageState();
}

class _usrTrendPageState extends State<usrTrendPage> {
  DateTime today = DateTime.now();
  static DateTime now = DateTime.now();
  int day = now.day;
  int month = now.month;
  int year = now.year;
  String userdayDate = '${now.day}-${now.month}-${now.year}';

  void topbackbtn() {
    Navigator.pop(context);
  }

  void _onDaySelected(DateTime yad, DateTime focusedDay) {
    setState(() {
      today = yad;
      usrTrendPage.Date = today.day.toString();
      usrTrendPage.Month = today.month.toString();
      usrTrendPage.Year = today.year.toString();
      usrTrendPage.finalDate =
          '${usrTrendPage.Date}-${usrTrendPage.Month}-${usrTrendPage.Year}';
      userdayDate = usrTrendPage.finalDate!;
    });
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
            topbackbtn();
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
                'Silahkan Pilih Tanggal Untuk\nMelihat Trend Lansia Minum Obat',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                    focusedDay: today,
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2040, 1, 1),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    onDaySelected: _onDaySelected,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                      Text('Data Tanggal $userdayDate'),
                      tTimeTable(pickHour1: '1', pickHour2: '2'),
                      tTimeTable(pickHour1: '3', pickHour2: '4'),
                      tTimeTable(pickHour1: '5', pickHour2: '6'),
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
