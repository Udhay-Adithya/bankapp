import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget BuildCustomSignButton(BuildContext context, String text, String route) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Color(0xffA01B29),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Color(0xffFFFFFF), // Blue border color
              width: 1, // Border width
            ),
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
              color: Colors.white),
        ),
      ),
    ),
  );
}
