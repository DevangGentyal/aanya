import 'package:Aanya/utils/type_def.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool obscureText;
  final ValidatorCallback validatorCallback;
  final bool enabled;
  const AuthInput({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.validatorCallback,
    required this.obscureText,
    this.enabled = true,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  @override
  Widget build(BuildContext context) {
    final double ffem = MediaQuery.of(context).textScaleFactor;

    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10 * ffem, horizontal: 10 * ffem),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        validator: widget.validatorCallback,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          labelText: widget.placeholder,
          labelStyle: TextStyle(
            color: Color.fromARGB(207, 255, 255, 255),
            fontSize: 12 * ffem,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(96, 255, 255, 255),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(96, 255, 255, 255),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(96, 255, 255, 255),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontSize: 14 * ffem,
        ),
      ),
    );
  }
}
