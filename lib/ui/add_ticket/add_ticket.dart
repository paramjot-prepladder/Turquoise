import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:testing/utils/common/common_widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  late TextEditingController _messageCtrl;
  late TextEditingController _noteCtrl;
  var _isLoading = false;

  @override
  void initState() {
    _messageCtrl = TextEditingController();
    _noteCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.whiteText,
                  elevation: 0,
                  toolbarHeight: 90,
                  flexibleSpace: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.greenPrimary,
                                size: 20,
                              ))),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('ADD TICKET',
                            style: TextStyle(
                                color: AppColors.greenPrimary,
                                fontWeight: FontWeight.w800,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                backgroundColor: AppColors.whiteText,
                body: Container(
                  padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) {
                            return FutureProvider(
                                create: (_) {
                                  return loginProvider.menuApi(
                                      context: context);
                                },
                                lazy: false,
                                initialData: ResponsePData(),
                                child: loginProvider.listProduct?.data != null
                                    ? DropdownMenu<String>(
                                        menuHeight: 400,
                                        leadingIcon: const Icon(
                                          Icons.production_quantity_limits,
                                          color: AppColors.greenPrimary,
                                        ),
                                        hintText: "Please select",
                                        width: 300,
                                        initialSelection: loginProvider
                                            .listProduct
                                            ?.data
                                            .products
                                            .first
                                            .name,
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValue = value!;
                                          });
                                        },
                                        dropdownMenuEntries: loginProvider
                                            .listProduct!.data.products
                                            .map<DropdownMenuEntry<String>>(
                                                (ResponsePDataProducts value) {
                                          return DropdownMenuEntry<String>(
                                              value: value.id.toString(),
                                              label: value.name,
                                              style: const ButtonStyle(
                                                  maximumSize: MaterialStatePropertyAll(Size(300,300)),
                                                  textStyle: MaterialStatePropertyAll(TextStyle(overflow: TextOverflow.ellipsis))
                                              ));
                                        }).toList(),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.pinkText,
                                        ),
                                      ));
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 300,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Serial Number',
                              prefixIcon: Icon(Icons.numbers),
                              prefixIconColor: AppColors.greenPrimary),
                          controller: _messageCtrl,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 300,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Note',
                              prefixIcon: Icon(Icons.note_alt),
                              prefixIconColor: AppColors.greenPrimary),
                          controller: _noteCtrl,
                        ),
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, loginProvider, _) {
                          return _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.pinkText,
                                  ),
                                )
                              : buttonRounded(
                                  text: 'Create Ticket',
                                  top: 30,
                                  onTap: () {
                                    debugPrint('prinint: login');
                                    _onTapBtn(loginProvider);
                                  },
                                );
                        },
                      )
                    ],
                  ),
                ))));
  }

  _onTapBtn(LoginProvider loginProvider) async {
    if (dropdownValue == "name") {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly select Product.",
        ),
      );
      return;
    } else if (_messageCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Serial Number.",
        ),
      );
      return;
    } else if (_noteCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Note.",
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    Map<String, String> body = Map();
    body['product_id'] = dropdownValue;
    body['serial_number'] = _messageCtrl.text;
    body['note'] = _noteCtrl.text;
    var result = await loginProvider.createTicket(body, context: context);
    setState(() => _isLoading = false);
    if (result?.status == true) {
      Navigator.of(context).pop(true);
      // Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: result?.message ?? '',
        ),
      );
    }
  }
}
