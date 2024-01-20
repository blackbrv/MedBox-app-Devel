import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/pages/trend_jadwal/jadwal_page.dart';
import 'package:medapp/pages/trend_jadwal/user_trend_page.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final String userName = AuthPage.x.toString();
  final db = FirebaseFirestore.instance;
  static String? nasia, usia, unicCode;
  Stream? userStream;

  //signuserout method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }

  //go to usertrendpage method
  void usrTrenPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return usrTrendPage();
      },
    ));
  }

  //go to usr jadwalpage method
  void usrToJadwalPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return usrJadwalPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    var heee = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "User Home Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout_rounded),
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Image(
                image: AssetImage(medUserImage),
                height: heee * 0.3,
              ),
              const SizedBox(height: 20),
              Text(
                "Medicine App",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              Text(
                "Selamat Datang " +
                    userName.capitalize() +
                    "\nApakah Sudah minum Obat ?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 25),
              StreamBuilder<Object>(
                  stream: db
                      .collection('profile')
                      .doc(AuthPage.x)
                      .snapshots()
                      .map((userLan) {
                    nasia = userLan.get('nama_lansia');
                    usia = userLan.get('umur_lansia');
                    unicCode = userLan.get('kode_alat');
                    return {};
                  }),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Text(
                          'Nama Lansia : ${nasia}',
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Umur Lansia : ${usia}',
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Kode Alat : ${unicCode}',
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: usrToJadwalPage,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: mSecondaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 100,
                            color: Colors.white,
                          ),
                          Text(
                            "Jadwal Lansia\nMinum Obat",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  GestureDetector(
                    onTap: usrTrenPage,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: mAccentColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 100,
                            color: mSecondaryColor,
                          ),
                          Text(
                            "Trend Lansia\nMinum Obat",
                            style: GoogleFonts.montserrat(
                              color: mSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        )));
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
