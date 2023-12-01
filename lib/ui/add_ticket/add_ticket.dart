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
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.greenPrimary,
            title: const Text('Add Ticket'),
          ),
          backgroundColor: AppColors.whiteText,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return FutureProvider(
                        create: (_) {
                          return loginProvider.menuApi(context: context);
                        },
                        lazy: false,
                        initialData: ResponsePData(),
                        child: loginProvider.listProduct?.data != null
                            ? DropdownMenu<String>(
                          hintText: "Please select",
                                width: 200,
                                initialSelection: loginProvider
                                    .listProduct?.data.products.first.name,
                                onSelected: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                dropdownMenuEntries: loginProvider.listProduct!.data.products
                                    .map<DropdownMenuEntry<String>>(
                                        (ResponsePDataProducts value) {
                                  return DropdownMenuEntry<String>(
                                      value: value.id.toString(), label: value.name);
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
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Serial Number',
                  ),
                  controller: _messageCtrl,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Note',
                  ),
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
                      : button(
                          text: 'Create Ticket',
                          onTap: () {
                            debugPrint('prinint: login');
                            _onTapBtn(loginProvider);
                          },
                        );
                },
              )
            ],
          ),
        ));
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
    }else if (_messageCtrl.text.isEmpty) {
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
