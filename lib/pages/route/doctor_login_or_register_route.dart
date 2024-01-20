import 'package:flutter/material.dart';
import 'package:medapp/pages/doctor/doctor_login_page.dart';
import 'package:medapp/pages/doctor/doctor_sign_up_page.dart';

class DoctorLoginOrRegisterPage extends StatefulWidget {
  const DoctorLoginOrRegisterPage({super.key});

  @override
  State<DoctorLoginOrRegisterPage> createState() =>
      _DoctorLoginOrRegisterPageState();
}

class _DoctorLoginOrRegisterPageState extends State<DoctorLoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return doctorLoginPage(
        onTap: togglePages,
      );
    } else {
      return doctorsignUpPage();
    }
  }
}
