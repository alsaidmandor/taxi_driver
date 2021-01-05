import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver/provider/app_provider.dart';
import 'package:taxi_driver/provider/user_provider.dart';
import 'package:taxi_driver/share/components.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: customText(
                  text: userProvider.userModel?.name ?? "",
                  size: 18,
                  weight: FontWeight.bold,
                ),
                accountEmail: customText(
                  text: userProvider.userModel?.email ?? "",
                )
            ) ,
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: customText(text: "Log out"),
              onTap: () {
                userProvider.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
