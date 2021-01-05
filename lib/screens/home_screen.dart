import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver/provider/app_provider.dart';
import 'package:taxi_driver/provider/user_provider.dart';
import 'package:taxi_driver/share/components.dart';
import 'package:taxi_driver/utils/style.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
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
                  )),
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
        body: Stack(
          children: [
            MapScreen(scaffoldState),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  MapScreen(this.scaffoldState);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = Provider.of<AppStateProvider>(context);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: appState.center, zoom: 15),
          onMapCreated: appState.onCreate,
          myLocationEnabled: true,
          mapType: MapType.normal,
          tiltGesturesEnabled: true,
          compassEnabled: false,
          markers: appState.markers,
          onCameraMove: appState.onCameraMove,
          polylines: appState.poly,
        ),
        Positioned(
            top: 10,
            left: 15,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: primary,
                size: 30,
              ),
              onPressed: () {
                scaffoldSate.currentState.openDrawer();
              },
            ))
      ],
    );
  }
}
