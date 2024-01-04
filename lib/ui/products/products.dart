import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/ui/register/register.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/color/app_colors.dart';
import '../change_password.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductListing();
  }
}

class _ProductListing extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: AppColors.greyLite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.greyLite)),
                      child: const ProductPreview(
                          title: "Oxygen Concentrator",
                          image: "assets/images/oxygen_concentrator.png",
                          externalUrl: "externalUrl",
                          price: "price"))),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: AppColors.greyLite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.greyLite)),
                      child: const ProductPreview(
                          title: "Masks",
                          image: "assets/images/mask.png",
                          externalUrl: "externalUrl",
                          price: "price"))),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: AppColors.greyLite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.greyLite)),
                      child: const ProductPreview(
                          title: "BiPAP",
                          image: "assets/images/bipap.png",
                          externalUrl: "externalUrl",
                          price: "price"))),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: AppColors.greyLite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.greyLite)),
                      child: const ProductPreview(
                          title: "CPAP",
                          image: "assets/images/cpap.png",
                          externalUrl: "externalUrl",
                          price: "price"))),
            ],
          )
        ],
      ),
    );
  }
}

class ProductPreview extends StatelessWidget {
  final String title;
  final String image;
  final String externalUrl;
  final String price;

  const ProductPreview(
      {super.key,
      required this.title,
      required this.image,
      required this.externalUrl,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.whiteText,
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 180,
              padding: const EdgeInsets.only(
                  top: 17, bottom: 17, left: 20, right: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(23))),
              child: Image(image: AssetImage(image)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(title,
                  style: const TextStyle(
                      color: AppColors.liteBlack, fontSize: 16)),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          _launchURL(Uri.parse(externalUrl));
                        },
                        child: const Text("Buy"))),
                Expanded(
                    child: TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Register()),
                          );
                        },
                        child: const Text("Support")))
              ],
            )
          ],
        ));
  }

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
