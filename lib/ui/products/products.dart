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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'TurQuoise',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.greenPrimary,
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.whiteText,
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      child: Text('PRODUCTS',
                          style: TextStyle(
                              color: AppColors.greenPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 18)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.greyLite,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.greyLite)),
                              child: const ProductPreview(
                                  title: "Oxygen Concentrator",
                                  image:
                                      "assets/images/oxygen_concentrator.png",
                                  externalUrl:
                                      "http://turquoise.cc/product-category/home-care/oxygen-therapy/",
                                  price: "price"))),
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.greyLite,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.greyLite)),
                              child: const ProductPreview(
                                  title: "Masks",
                                  image: "assets/images/mask.png",
                                  externalUrl:
                                      "http://turquoise.cc/product-category/home-care/patient-interface/full-face-masks/",
                                  price: "price"))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.greyLite,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.greyLite)),
                              child: const ProductPreview(
                                  title: "BiPAP",
                                  image: "assets/images/bipap.png",
                                  externalUrl:
                                      "http://turquoise.cc/product-category/home-care/sleep-apnea-therapy/",
                                  price: "price"))),
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.greyLite,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.greyLite)),
                              child: const ProductPreview(
                                  title: "CPAP",
                                  image: "assets/images/cpap.png",
                                  externalUrl:
                                      "http://turquoise.cc/product-category/home-care/sleep-apnea-therapy/cpap-and-apap-devices/",
                                  price: "price"))),
                    ],
                  )
                ],
              ),
            )));
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
                  top: 10, bottom: 10, left: 20, right: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(23))),
              child: Image(image: AssetImage(image)),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.only(top: 5, bottom: 15),
              child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.liteBlack, fontSize: 14)),
            ),
            Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                      _launchURL(Uri.parse(externalUrl));
                    },
                    child: const Text("Buy", style: TextStyle(fontSize: 12))),
                TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                    child:
                        const Text("Support", style: TextStyle(fontSize: 12)))
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
