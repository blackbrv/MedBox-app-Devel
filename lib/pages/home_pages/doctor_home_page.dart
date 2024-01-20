import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp/pages/doctor/search_trend_page/doctor_search_page.dart';
import 'package:medapp/pages/route/doctor_auth.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class DoctorHomePage extends StatefulWidget {
  DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final String name = doctorAuthPage.x.toString();
  //signuserout method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  //go to usertrendpage method
  void dctrTrenPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return dSearchPage();
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
            "Dokter Home Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(
            Icons.person_2_outlined,
            color: Colors.white.withOpacity(0),
          ),
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
                image: AssetImage(medDoctorImage),
                height: heee * 0.3,
              ),
              const SizedBox(height: 20),
              Text(
                "Medicine App",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              Text(
                "Selamat Datang Dokter!,\nSilahkan melakukan pemeriksaan\nuntuk pengobatan lansia",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 25),
              Text("Dokter " + name.capitalize(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(
                height: 5,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: dctrTrenPage,
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
                            Icons.person_search_rounded,
                            size: 70,
                            color: mSecondaryColor,
                          ),
                          Text(
                            "Cari Lansia!",
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
