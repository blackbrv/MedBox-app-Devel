import 'package:flutter/material.dart';
import 'package:medapp/components/all_square_tile/square_tile.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/pages/route/doctor_auth.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class pickOne extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  pickOne({super.key});

  void signIn() {}

  @override
  Widget build(BuildContext context) {
    var heee = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Image(
                image: const AssetImage(medSplashImage),
                height: heee * 0.4,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Medicine App",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Selamat Datang Apakah Anda User Atau Dokter ?",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AuthPage();
                          }));
                        },
                        child: const SquareTile(
                          imagePath: medUserImage,
                          colorPicky: mSlightlydarkwhite,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "User",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return doctorAuthPage();
                          }));
                        },
                        child: const SquareTile(
                          imagePath: medDoctorImage,
                          colorPicky: mSlightlydarkwhite,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Dokter",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
