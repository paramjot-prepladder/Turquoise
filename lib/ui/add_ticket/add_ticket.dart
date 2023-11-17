import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../model/product/response_p_entity.dart';
import '../../provider/login_provider.dart';
import '../../utils/color/app_colors.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddTicket();
  }
}

String dropdownValue = "name";

class _AddTicket extends State<AddTicket> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.liteBlack,
            title: const Text('Menu info'),
          ),
          backgroundColor: AppColors.whiteText,
          body: Consumer<LoginProvider>(
            builder: (context, loginProvider, child) {
              return FutureProvider(
                  create: (_) {
                    return loginProvider.menuApi(context: context);
                  },
                  lazy: false,
                  initialData: ResponsePData(),
                  child: loginProvider.listProduct?.data != null
                      ? DropdownMenu<String>(
                          initialSelection: loginProvider
                              .listProduct?.data.products.first.name,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: loginProvider.s!
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        )
                      /*ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              loginProvider.listProduct?.data.products.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                debugPrint(
                                    "click child  ${loginProvider.listProduct?.data.products[index].name}");
                              },
                              child: Column(
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
                              ),
                            );
                          },
                        )*/
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pinkText,
                          ),
                        ));
            },
          ),
        ));
  }
}
