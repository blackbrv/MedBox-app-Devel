import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/components/all_controller.dart';
import 'package:medapp/components/input_hour.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class addJadwalPage extends StatefulWidget {
  const addJadwalPage({super.key});
  static DateTime now = new DateTime.now();

  @override
  State<addJadwalPage> createState() => _addJadwalPageState();
}

class _addJadwalPageState extends State<addJadwalPage> {
  int year = addJadwalPage.now.year;
  int month = addJadwalPage.now.month;
  int day = addJadwalPage.now.day;
  final db = FirebaseFirestore.instance;
  String? unicCode;

  void backToUsrHomePage() {
    Navigator.pop(context);
  }

  void routeToHomePage() {
    saveHourData();
    Navigator.pop(context);
  }

  void saveHourData() {
    getUnicCode();
    DocumentReference docRefHourData = FirebaseFirestore.instance
        .collection(unicCode!)
        .doc('hour_data_${day}-${month}-${year}');
    Map<String, dynamic> mapOfSaveHourData = {
      'jam1': jam1controller.text + ':' + menit1controller.text,
      'jam2': jam2controller.text + ':' + menit2controller.text,
      'jam3': jam3controller.text + ':' + menit3controller.text,
      'jam4': jam4controller.text + ':' + menit4controller.text,
      'jam5': jam5controller.text + ':' + menit5controller.text,
      'jam6': jam6controller.text + ':' + menit6controller.text,
    };
    docRefHourData.set(mapOfSaveHourData);
  }

  getUnicCode() {
    DocumentReference doRefUnicCode =
        db.collection(AuthPage.x.toString()).doc('profil_lansia');
    doRefUnicCode.get().then((cdoe) {
      unicCode = cdoe.get('kode_alat');
    });
  }

  @override
  void initState() {
    getUnicCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screnHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Registrasi Jadwal Baru",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: backToUsrHomePage,
          alignment: Alignment.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Image(
                image: AssetImage(medSplashImage),
                height: screnHeight * 0.3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    'Silahkan melakukan Registrasi\nJadwal Obat Baru Untuk Lansia',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              const SizedBox(height: 25),
              Text(
                "Input Jam dengan format 24 jam\n*Contoh = 21:39 = menunjukan pukul 9:39 malam ",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              inputJam(
                jamcontroller: jam1controller,
                menitcontroller: menit1controller,
                indexHour: '1',
              ),
              const SizedBox(height: 25),
              inputJam(
                jamcontroller: jam2controller,
                menitcontroller: menit2controller,
                indexHour: '2',
              ),
              const SizedBox(height: 25),
              inputJam(
                jamcontroller: jam3controller,
                menitcontroller: menit3controller,
                indexHour: '3',
              ),
              const SizedBox(height: 25),
              inputJam(
                jamcontroller: jam4controller,
                menitcontroller: menit4controller,
                indexHour: '4',
              ),
              const SizedBox(height: 25),
              inputJam(
                jamcontroller: jam5controller,
                menitcontroller: menit5controller,
                indexHour: '5',
              ),
              const SizedBox(height: 25),
              inputJam(
                jamcontroller: jam6controller,
                menitcontroller: menit6controller,
                indexHour: '6',
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: routeToHomePage,
                child: Text(
                  "Simpan Data Lansia",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  backgroundColor: mSecondaryColor,
                  foregroundColor: mAccentColor,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
