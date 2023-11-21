import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/ui/add_ticket/add_ticket.dart';

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
              title: const Text('Tickets'),
            ),
            backgroundColor: AppColors.whiteText,
            body: Consumer<LoginProvider>(
              builder: (context, loginProvider, child) {
                return FutureProvider(
                    create: (_) {
                      return loginProvider.getTickets(context: context);
                    },
                    lazy: false,
                    initialData: ResponsePData(),
                    child: loginProvider.ticket != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: loginProvider.ticket?.length,
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
                                          '${loginProvider.ticket?[index].type}',
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
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )));
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTicket()),
    );
  }
}
