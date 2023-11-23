import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/ui/add_ticket/add_ticket.dart';

import '../../model/product/response_p_entity.dart';
import '../../provider/menu_provider.dart';
import '../../utils/color/app_colors.dart';

import '../../provider/login_provider.dart';
import '../chat/chat.dart';

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
                              return GestureDetector(
                                onTap: () {
                                  _openChat(loginProvider.ticket?[index].id
                                      .toString());
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      height: 60,
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            '${loginProvider.ticket?[index].type} ${loginProvider.ticket?[index].id}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: AppColors.liteBlack,
                                                fontSize: 20)),
                                      ),
                                    )),
                                    Container(
                                      color: AppColors.greenPrimary,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(right: 10),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Complete",
                                          style: TextStyle(
                                              color: AppColors.whiteText),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.greenPrimary,
                            ),
                          ));
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              backgroundColor: AppColors.greenPrimary,
              tooltip: 'Add Ticket',
              child: const Icon(Icons.add),
            )));
  }

  void _openChat(String? ticket) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chat(ticketId: ticket ?? "1")),
    );
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTicket()),
    );
  }
}
