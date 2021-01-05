import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver/provider/app_provider.dart';
import 'package:taxi_driver/provider/user_provider.dart';
import 'package:taxi_driver/screens/home_screen.dart';
import 'package:taxi_driver/share/buildPasswordTextForm.dart';
import 'package:taxi_driver/share/components.dart';
import 'package:taxi_driver/utils/style.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider authProvider = Provider.of<UserProvider>(context);
    AppStateProvider app = Provider.of<AppStateProvider>(context);

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
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                  spacer(40),
                  SizedBox(
                    height: 20,
                  ),
                  buildTextForm(
                      controller: authProvider.name,
                      labTxt: "Name",
                      hintTxt: 'eg: mohamed ali',
                      icons: Icons.person),
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
                  buildTextForm(
                      controller: authProvider.phone,
                      labTxt: "Phone",
                      hintTxt: '+91 3213452',
                      icons: Icons.phone),
                  customButton(
                      onTap: () async {
                        if (!await authProvider.signUp()) {
                          showToast("Register failed!", Colors.red);
                          return;
                        }
                        authProvider.clearController();
                        showToast("Register correct!", Colors.green);
                        changeScreenReplacement(context, HomeScreen());
                      },
                      text: "Register"),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        customText(
                          text: "Login here",
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
