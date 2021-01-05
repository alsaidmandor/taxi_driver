import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver/provider/user_provider.dart';
import 'package:taxi_driver/screens/home_screen.dart';
import 'package:taxi_driver/screens/register_screen.dart';
import 'package:taxi_driver/share/buildPasswordTextForm.dart';
import 'package:taxi_driver/share/components.dart';
import 'package:taxi_driver/utils/style.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: authProvider.status == Status.Authenticating
          ? loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  spacer(100),
                  Container(
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/lg.png",
                          width: 230,
                          height: 230,
                        ),
                      ],
                    ),
                  ),
                  spacer(60),
                  SizedBox(
                    height: 20,
                  ),
                  buildTextForm(
                      controller: authProvider.email,
                      labTxt: "Email",
                      hintTxt: 'eg: mohamed @gmail.com',
                      icons: Icons.email),
                  BuildPasswordTextForm(
                    controller: authProvider.password,
                    labTxt: 'Password',
                    hintTxt: 'at least 6 digits',
                  ),
                  customButton(
                      onTap: () async {
                        if (!await authProvider.signIn()) {
                          showToast("Login failed!", Colors.red);
                          return;
                        }
                        authProvider.clearController();
                        showToast("Login correct!", Colors.green);
                        changeScreenReplacement(context, HomeScreen());
                      },
                      text: 'Login'),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, RegisterScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        customText(
                          text: "Register here",
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
