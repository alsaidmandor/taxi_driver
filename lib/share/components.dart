import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi_driver/services/stars.dart';
import 'package:taxi_driver/utils/style.dart';

Widget loading() {
  return Container(
    child: CircularProgressIndicator(),
  );
}

Widget spacer(double height) => Container(
      color: white,
      height: height,
    );

Widget buildTextForm({controller, labTxt, hintTxt, icons}) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: white),
              border: InputBorder.none,
              labelText: labTxt,
              hintText: hintTxt,
              icon: Icon(
                icons,
                color: white,
              )),
        ),
      ),
    ),
  );
}

Widget customText({@required text, double size, color, weight}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? black,
        fontWeight: weight ?? FontWeight.normal),
  );
}

Widget customButton({onTap, text}) {
  bool isClick = false;
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(color: black, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              customText(
                text: text,
                color: white,
                size: 22,
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void showToast(text, color) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

stars({double votes, double rating}) {
  if (votes == 0) {
    return StarsWidget(numberOfStars: 0);
  } else {
    double finalRate = rating / votes;
    return StarsWidget(numberOfStars: finalRate);
  }
}
