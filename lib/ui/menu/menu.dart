import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product/response_p_entity.dart';
import '../../provider/menu_provider.dart';
import '../../utils/color/app_colors.dart';

import '../../provider/login_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuProvider? provider;

  @override
  void initState() {
    super.initState();
    // providerInit();
    //  WidgetsBinding.instance?.addPostFrameCallback(
    //       (_) => _provider?.fundsWithCategory(context: context));
  }

  providerInit() {
    provider = Provider.of<MenuProvider>(context, listen: false);
    provider?.menuApi(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.liteBlack,
            title: Text('Menu info'),
          ),
          backgroundColor: AppColors.whiteText,
          body: Container(child: Consumer<LoginProvider>(
            builder: (context, loginProvider, child) {
              return FutureProvider(
                  create: (_) {
                    return loginProvider.menuApi(context: context);
                  },
                  lazy: false,
                  initialData: ResponsePData(),
                  child: loginProvider.listProduct?.data != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              loginProvider.listProduct?.data.products.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height: 60,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${loginProvider.listProduct?.data.products[index].name}',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: AppColors.liteBlack,
                                            fontSize: 20)),
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pinkText,
                          ),
                        ));
            },
          )
              /*child: Consumer<LoginProvider>(
              builder: (context, menuProvider, _) {
                return FutureProvider(
                  create: (_) {
                    return menuProvider.menuApi(context: context);
                  },
                  lazy: false,
                  initialData: DemoResponse(),
                  child: menuProvider.listProduct?.data.products != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: menuProvider.listProduct?.data.products.length ?? 0,
                          itemBuilder: (ctx, i) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  // color: AppColors.iconGrey,
                                  height: 60,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${menuProvider.listProduct?.data.products[i].name}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.liteBlack,
                                          fontSize: 20),
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
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pinkText,
                          ),
                        ),
                );
              },
            ),*/
              ),
        ));
  }
}
