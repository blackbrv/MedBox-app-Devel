import 'package:flutter/material.dart';
import 'package:medapp/components/all_text.dart';
import 'package:medapp/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medapp/components/my_text_field.dart';
import 'package:medapp/pages/route/doctor_auth.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class doctorsignUpPage extends StatefulWidget {
  doctorsignUpPage({super.key, this.leading});

  final Widget? leading;

  @override
  State<doctorsignUpPage> createState() => _doctorsignUpPageState();
}

class _doctorsignUpPageState extends State<doctorsignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final verifDoc = emailController.text.contains("dok");
    if (verifDoc == true) {
      if (passwordController.text == confirmPasswordController.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          showErrorMessage(e.code);
        }
      } else {
        Navigator.pop(context);
        showErrorMessage(wrongPass);
      }
    } else {
      Navigator.pop(context);
      showErrorMessage(areUAUser);
    }
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
    var heee = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dokter Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mSecondaryColor,
          ),
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return doctorAuthPage();
              }));
            },
            icon: Icon(Icons.arrow_back_ios),
          );
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image(
                image: AssetImage(medSplashImage),
                height: heee * 0.4,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Medicine App",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Selamat Datang Silahkan Daftar Terlebih Dahulu",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 25,
              ),
              mTextField(
                controller: emailController,
                obsecureText: false,
                hintText: "Email *ex : tama@dokter.gmail.com",
              ),
              const SizedBox(
                height: 10,
              ),
              mTextField(
                controller: passwordController,
                hintText: "Password",
                obsecureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              mTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obsecureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              MButton(
                SignInSignUptext: "Sign Up",
                btnColors: mSecondaryColor,
                OnTap: signUp,
                TTColor: mAccentColor,
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
