import 'package:flutter/foundation.dart';
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

class _MenuScreenState extends State<MenuScreen> with WidgetsBindingObserver {
  MenuProvider? provider;
  bool shouldCallApi = true;

  @override
  void initState() {
    super.initState();

    // providerInit();
    WidgetsBinding.instance.addObserver(this);
    // WidgetsBinding.instance?.addPostFrameCallback(
    //      (_) => _provider?.fundsWithCategory(context: context));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("here with bang dispose ${state}");
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("here with bang dispose");
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    debugPrint("here with bang reassemble");
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
            backgroundColor: AppColors.whiteText,
            body: Consumer<LoginProvider>(
              builder: (context, loginProvider, child) {
                if (shouldCallApi) {
                  callFuture(loginProvider);
                }
                return loginProvider.ticket != null
                    ? loginProvider.ticket?.isNotEmpty == true
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                height: 60,
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${loginProvider.ticket?[index]
                                              .productName} ${loginProvider
                                              .ticket?[index].id}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: AppColors.liteBlack,
                                              fontSize: 20)),
                                      Text(
                                          '${loginProvider.ticket?[index]
                                              .time}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: AppColors.greyText,
                                              fontSize: 10))
                                    ],
                                  ),
                                ),
                              )),
                          Row(
                            children: [

                              loginProvider.ticket?[index]
                                  .unreadMessages != "0"

                                  ? Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.only(
                                    right: 10),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            20.0)),
                                    color: Colors.red),
                                child: Text(
                                    loginProvider.ticket?[index]
                                        .unreadMessages ??
                                        '',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight.w900)),
                              )
                                  : Text(""),
                              Container(
                                color: AppColors.greenPrimary,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                margin:
                                const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${loginProvider.ticket?[index]
                                        .ticketStatus}',
                                    style: const TextStyle(
                                        color: AppColors.whiteText),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Text("No Ticket found"),
                )
                    : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenPrimary,
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: _incrementCounter,
              backgroundColor: AppColors.greenPrimary,
              tooltip: 'Add Ticket',
              label: const Text("Raise Ticket"),
            )));
  }

  void callFuture(LoginProvider loginProvider) async {
    await loginProvider.getTickets(context: context);
    setState(() {
      shouldCallApi = false;
    });
  }

  void _openChat(String? ticket) async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chat(ticketId: ticket ?? "1")),
    );
    setState(() {
      shouldCallApi = true;
    });
  }

  Future<void> _incrementCounter() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTicket()),
    );

    if (shouldRefresh ?? false) {
      setState(() {
        shouldCallApi = true;
      });
    }
  }
}
