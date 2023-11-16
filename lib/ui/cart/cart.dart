import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../../utils/color/app_colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.liteBlack,
        title: Text('Cart'),
      ),
      backgroundColor: AppColors.whiteText,
      body: Container(
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: homeProvider.itemList.length,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      color: AppColors.iconGrey,
                      height: 60,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${homeProvider.itemList[i].itemName}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.whiteText, fontSize: 20),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColors.greylight,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
