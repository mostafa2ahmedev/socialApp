import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/LoginComponent.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/RegisterView/RegisterView.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/loginview/loginview.dart';
import 'package:firebasepro/core/globalMethods.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/vector1.jfif',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SOCIAL',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'TIC',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'its easier to sign up now',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Continue with FaceBook',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(300, 45),
                side: const BorderSide(color: Colors.black, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                GlobalMethod.navigato(context, view: const RegisterView());
              },
              child: Text(
                'Sign up with email',
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginComponent(
                  iconData: FontAwesomeIcons.twitter,
                ),
                SizedBox(
                  width: 15,
                ),
                LoginComponent(
                  iconData: FontAwesomeIcons.googlePlusG,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 15,
                ),
                LoginComponent(
                  iconData: FontAwesomeIcons.linkedinIn,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      GlobalMethod.navigato(context, view: const LoginView());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 17, color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
