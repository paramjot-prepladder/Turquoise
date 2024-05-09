import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/ui/register/register.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/login_provider.dart';
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
  bool shouldCallApi = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: const BackButton(color: Colors.white,),
                  title: const Text(
                    'TurQuoise',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.greenPrimary,
                ),
                backgroundColor: AppColors.whiteText,
                body: Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  _registerDeviceId(loginProvider);

                  if (shouldCallApi) {
                    loginProvider.categoryRequest(context: context);
                    shouldCallApi = false;
                  }
                  return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      physics: ScrollPhysics(),
                      children: List.generate(
                          loginProvider.listCategory?.data.categories.length ??
                              0, (index) {
                        var data =
                            loginProvider.listCategory?.data.categories[index];
                        return  Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 5),
                                // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: AppColors.greyLite,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColors.greyLite)),
                                child: ProductPreview(
                                    title: data?.name ?? "",
                                    image: data?.image ?? "",
                                    externalUrl: data?.redirectUrl ?? "",
                                    price: "price"));
                      }));
                }))));
  }

  Future<void> _registerDeviceId(LoginProvider loginProvider) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var a = await messaging.getToken();
    Map<String, String> body = Map();
    body['device_id'] = a!;
    var result = await loginProvider.registerDeviceId(body, context: context);
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
              child: Image.network(image),
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
