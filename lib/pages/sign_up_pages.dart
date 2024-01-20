import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medapp/components/all_text.dart';
import 'package:medapp/components/my_button.dart';
import 'package:medapp/components/my_text_field.dart';
import 'package:medapp/pages/auth_page.dart';
import 'package:medapp/pages/regis_lansia_page/reg_lansia_page.dart';
import 'package:medapp/utils/colors.dart';
import 'package:medapp/utils/image_string.dart';

class signUpPage extends StatefulWidget {
  signUpPage({
    super.key,
    this.leading,
  });

  final Widget? leading;
  static bool? regLansia = false;

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final verifDoc = _emailController.text.contains("dok");
    if (verifDoc == false) {
      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _emailController.text,
          );
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          showErrorMessage(e.code);
        }
        saveEmailandPass();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => regisLansiaPage()));
      } else {
        Navigator.pop(context);
        showErrorMessage(wrongPass);
      }
    } else {
      Navigator.pop(context);
      showErrorMessage(areUADoc);
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

  void saveEmailandPass() {
    var collectionName = _emailController.text.split("@gmail.com");
    String? trimmedCollectionName = collectionName[0].trim();
    DocumentReference saveUserData = FirebaseFirestore.instance
        .collection('profile')
        .doc(trimmedCollectionName);
    Map<String, dynamic> UserData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    saveUserData.set(UserData);
  }

  @override
  Widget build(BuildContext context) {
    var heee = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Sign Up",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AuthPage();
              }));
            },
            icon: Icon(Icons.arrow_back_ios),
          );
        }),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Image(
                image: AssetImage(medSplashImage),
                height: heee * 0.3,
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
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 25,
              ),
              mTextField(
                controller: _emailController,
                obsecureText: false,
                hintText: "Email",
              ),
              const SizedBox(
                height: 10,
              ),
              mTextField(
                controller: _passwordController,
                hintText: "Password",
                obsecureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              mTextField(
                controller: _confirmPasswordController,
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
