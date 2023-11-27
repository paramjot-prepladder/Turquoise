import 'package:flutter/material.dart';
import 'package:testing/utils/color/app_colors.dart';

Widget button({
  Color? color,
  required Function onTap,
  String? text,
  Color? colorText,
  Color? borderColor,
  double? borderRadius,
}) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        textStyle:  const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteText),
      ),
      child: Text(text ?? ''),
    ),
  );
}

Widget sizedBox({double? wid, double? hei, required BuildContext context}) {
  return SizedBox(
    width: wid != null ? MediaQuery.of(context).size.width * wid : 0,
    height: hei != null ? MediaQuery.of(context).size.height * hei : 0,
  );
}
