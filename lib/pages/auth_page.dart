import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/pages/home_pages/user_home_page.dart';
import 'package:medapp/pages/login_or_register_page.dart';
import 'package:medapp/pages/route/doctor_auth.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  static bool usrlgn = false;
  static bool docYes = doctorAuthPage.y;
  static var x;
  static String? namaFromEmail;

  void checkfunction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //if user login
        if (snapshot.hasData) {
          var usrident = snapshot.data?.email.toString();
          var usrmail = snapshot.data?.email?.split("@gmail.com");
          if (usrident != null) {
            var usrid = usrmail?[0].trim();
            final docverif = usrident.contains("dok");
            if (docverif == false) {
              print(usrid);
              x = usrid;
              usrlgn = true;
              namaFromEmail = usrid;
              return UserHomePage();
            } else {
              usrlgn = false;
            }
          }
        }
        return LoginOrRegisterPage();
      },
    ));
  }
}
