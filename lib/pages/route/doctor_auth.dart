import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/pages/home_pages/doctor_home_page.dart';
import 'package:medapp/pages/route/doctor_login_or_register_route.dart';

class doctorAuthPage extends StatelessWidget {
  doctorAuthPage({super.key});

  static var x;
  static bool y = false;
  static bool userlogin = AuthPage.usrlgn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var mailForIden = snapshot.data?.email?.toString();
          var mail = snapshot.data?.email?.split("@dokter.gmail.com");
          if (mailForIden != null) {
            var id = mail?[0].trim();
            //identification for doctor or not ?
            final iden = mailForIden.contains("dok");
            //if user login
            if (iden == true && userlogin == false) {
              y = true;
              x = id;
              print(x); // This line is changed
              return DoctorHomePage();
            } else {
              y = false;
            }
          }
        }
        return DoctorLoginOrRegisterPage();
      },
    ));
  }
}
