import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/components/all_controller.dart';
import 'package:medapp/components/input_hour.dart';
import 'package:medapp/components/my_text_field.dart';
import 'package:medapp/components/qr_code_scanner.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/pages/home_pages/user_home_page.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class regisLansiaPage extends StatefulWidget {
  regisLansiaPage({
    super.key,
    this.qrCodeResult,
    this.scanDone,
  });
  static DateTime now = new DateTime.now();
  final String? qrCodeResult;
  static var callTime;
  static String? qrSaveData;
  final bool? scanDone;

  @override
  State<regisLansiaPage> createState() => _regisLansiaPageState();
}

class _regisLansiaPageState extends State<regisLansiaPage> {
  final namaLansiaController = TextEditingController();
  final umurLansiaController = TextEditingController();
  bool doneRegis = false;
  int year = regisLansiaPage.now.year;
  int month = regisLansiaPage.now.month;
  int day = regisLansiaPage.now.day;
  //var barcodeRslt = qrCodeScanner.brcdoe;

  void routeToHomePage() {
    if (widget.scanDone == true) {
      saveProfileLansia();
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (context) => UserHomePage()));
    } else {
      showErrorMessage("Scan QR Code Alat Terlebih Dahulu");
    }
  }

  void saveProfileLansia() {
    DocumentReference docRefDataLansia = FirebaseFirestore.instance
        .collection('profile')
        .doc(AuthPage.x.toString());
    Map<String, dynamic> thisCall = {
      'nama_Lansia': namaLansiaController.text,
      'umur_Lansia': umurLansiaController.text,
      'kode_alat': widget.qrCodeResult,
    };
    docRefDataLansia.set(thisCall);
    saveHourData();
  }

  void saveHourData() {
    DocumentReference docRefHourData = FirebaseFirestore.instance
        .collection(widget.qrCodeResult!)
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

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screnHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Registrasi Lansia",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
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
                    'Silahkan melakukan Registrasi\nBiodata Lansia terlebih dahulu',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.person_4_outlined,
                      size: 35,
                    ),
                    Expanded(
                      child: namaOrUmurField(
                          namaOrUmurctrler: namaLansiaController,
                          noUHintText: "Nama Lansia"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.person_4_rounded,
                      size: 35,
                    ),
                    Expanded(
                      child: namaOrUmurField(
                          namaOrUmurctrler: umurLansiaController,
                          noUHintText: "Umur Lansia"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(85, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => qrCodeScanner(),
                            ));
                      },
                      child: Text(
                        "Koneksikan Ke Alat",
                        style: GoogleFonts.montserrat(
                          color: mSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          backgroundColor: mAccentColor),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.qrCodeResult ?? '',
                      style: GoogleFonts.montserrat(
                        color: mSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
