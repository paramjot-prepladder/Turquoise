import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/utils/color/app_colors.dart';

import '../home_tab/tab.dart';
import '../products/products.dart';
import '../register/register.dart';

class Selection extends StatefulWidget {
  const Selection({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Selection();
  }
}

class _Selection extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/turquoise_bg.png")),
      ),
      child: Container(
          padding: const EdgeInsets.only(top: 160, left: 24, right: 24),
          child: Column(children: [
            Image.asset("assets/icon/launcher_icon.png"),
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                          color: AppColors.skyBlack,
                        ),
                        children: [
                          TextSpan(text: "No more hassle to connect with our"),
                          TextSpan(
                              text: " support ",
                              style: TextStyle(color: AppColors.skyGreen)),
                          TextSpan(text: "or buy our"),
                          TextSpan(
                              text: " products ",
                              style: TextStyle(color: AppColors.skyGreen)),
                          TextSpan(text: ", now it's quick and simple"),
                        ]))),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductListing()),
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.skyGreenGreen),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                                color: AppColors.skyGreenGreen))),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteText),
                  ),
                )),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var token = prefs.getString('token');
                    if (token == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TabHome()),
                      );
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.skyGreenDark),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                                color: AppColors.skyGreenDark))),
                  ),
                  child: const Text(
                    'Connect with Support',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteText),
                  ),
                ))
          ])),
    )));
  }
}
