import 'package:flutter/material.dart';

Widget button({
  Color? color,
  required Function onTap,
  String? text,
  Color? colorText,
  Color? borderColor,
  double? borderRadius,
}) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: ElevatedButton(
      child: Text(text ?? ''),
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget sizedBox({double? wid, double? hei, required BuildContext context}) {
  return SizedBox(
    width: wid != null ? MediaQuery.of(context).size.width * wid : 0,
    height: hei != null ? MediaQuery.of(context).size.height * hei : 0,
  );
}
