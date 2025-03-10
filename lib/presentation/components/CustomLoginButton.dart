import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget BuildCustomLoginButton(BuildContext context, String text, String route) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Color(0xffFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'LexendDeca',
            fontWeight: FontWeight.w600,
            color: Color(0xffA01B29),
          ),
        ),
      ),
    ),
  );
}
