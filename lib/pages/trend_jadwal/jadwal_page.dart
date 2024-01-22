import 'package:flutter/material.dart';
import 'package:medapp/components/med_time_tables.dart';
import 'package:medapp/pages/home_pages/user_home_page.dart';
import 'package:medapp/pages/trend_jadwal/add_jadwal.dart';
import 'package:medapp/utils/colors.dart';

// ignore: camel_case_types
class usrJadwalPage extends StatefulWidget {
  const usrJadwalPage({super.key});

  @override
  State<usrJadwalPage> createState() => _usrJadwalPageState();
}

// ignore: camel_case_types
class _usrJadwalPageState extends State<usrJadwalPage> {
  void backToUsrHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => UserHomePage())));
  }

  void addJadwal() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => addJadwalPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Jadwal Lansia Minum Obat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: backToUsrHomePage,
          alignment: Alignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addJadwal,
        shape: const CircleBorder(),
        child: Icon(Icons.add),
        backgroundColor: mSecondaryColor,
        foregroundColor: mAccentColor,
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            medTimeTable(pickHour1: '1', pickHour2: '2'),
            medTimeTable(pickHour1: '3', pickHour2: '4'),
            medTimeTable(pickHour1: '5', pickHour2: '6'),
          ],
        ),
      )),
    );
  }
}
