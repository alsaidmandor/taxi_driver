import 'package:flutter/material.dart';
import 'package:taxi_driver/utils/style.dart';

class BuildPasswordTextForm extends StatefulWidget {
  TextEditingController controller;
  String labTxt, hintTxt;

  BuildPasswordTextForm({@required this.controller, this.labTxt, this.hintTxt});

  @override
  _BuildPasswordTextFormState createState() => _BuildPasswordTextFormState();
}

class _BuildPasswordTextFormState extends State<BuildPasswordTextForm> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
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
            obscureText: obscureText,
            controller: widget.controller,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: white),
              border: InputBorder.none,
              labelText: widget.labTxt,
              hintText: widget.hintTxt,
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText == true ? Icons.visibility : Icons.visibility_off,
                  color: white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
