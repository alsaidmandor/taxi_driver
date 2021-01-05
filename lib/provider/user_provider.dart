import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_driver/model/user.dart';
import 'package:taxi_driver/services/user.dart';
import 'package:taxi_driver/utils/constants.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel _userModel;
  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  // public variables
  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  UserProvider.initialize() {
    _fireSetUp();
  }

  _fireSetUp() async {
    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<bool> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        await prefs.setString("id", value.user.uid);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(Position position) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _deviceToken = await fcm.getToken();
        await prefs.setString("id", result.user.uid);
        // _userServices.createUser(
        //     id: result.user.uid,
        //     name: name.text.trim(),
        //     email: email.text.trim(),
        //     phone: phone.text.trim(),
        //     position: position.toJson(),
        //     token: _deviceToken);
        users
            .doc(result.user.uid)
            .set({
              "name": name.text.trim(),
              "id": result.user.uid.trim(),
              "phone": phone.text.trim(),
              "email": email.text.trim(),
              "votes": 0.0,
              "trips": 0.0,
              "rating": 0.0,
              "position": result.user.uid,
              "car": "Toyota Corolla",
              "plate": "CBA 321 7",
              "token": _deviceToken
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    phone.text = "";
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> data) async {
    _userServices.updateUserData(data);
  }

  saveDeviceToken() async {
    String deviceToken = await fcm.getToken();
    if (deviceToken != null) {
      _userServices.addDeviceToken(userId: user.uid, token: deviceToken);
    }
  }

  _onStateChanged(User firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      await prefs.setString("id", firebaseUser.uid);
      // _status = Status.Authenticated;

      _userModel = await _userServices.getUserById(user.uid).then((value) {
        _status = Status.Authenticated;
        return value;
      });
    }
    notifyListeners();
  }
}
