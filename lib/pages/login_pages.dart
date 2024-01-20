import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/components/my_button.dart';
import 'package:medapp/components/my_text_field.dart';
import 'package:medapp/pages/doctor_or_user_page.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final Widget? leading;
  LoginPage({super.key, required this.onTap, this.leading});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final verDoc = emailController.text.contains("dok");
    if (verDoc == false) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
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
      showErrorMessage("Apakah Anda Dokter ?");
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
          "User Sign In",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mSecondaryColor,
          ),
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return pickOne();
              }));
            },
            icon: Icon(Icons.arrow_back_ios),
          );
        }),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 1),
              Image(
                image: AssetImage(medSplashImage),
                height: heee * 0.3,
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                "Medicine App",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Selamat Datang Silahkan Sign In Terlebih Dahulu",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 25.0,
              ),
              mTextField(
                controller: emailController,
                obsecureText: false,
                hintText: "Email",
              ),
              const SizedBox(
                height: 20.0,
              ),
              mTextField(
                controller: passwordController,
                obsecureText: true,
                hintText: "Password",
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              MButton(
                SignInSignUptext: "Sign In",
                btnColors: mSecondaryColor,
                OnTap: signIn,
                TTColor: mAccentColor,
              ),
              const SizedBox(
                height: 10,
              ),
              MButton(
                SignInSignUptext: "Sign Up",
                btnColors: mAccentColor,
                OnTap: widget.onTap,
                TTColor: mSecondaryColor,
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
