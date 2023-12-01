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
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      height: 60,
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            '${loginProvider.ticket?[index].productName} ${loginProvider.ticket?[index].id}',
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
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${loginProvider.ticket?[index].ticketStatus}',
                                          style: const TextStyle(
                                              color: AppColors.whiteText),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : const Text("No Ticket found")
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.greenPrimary,
                        ),
                      );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              backgroundColor: AppColors.greenPrimary,
              tooltip: 'Add Ticket',
              child: const Icon(Icons.add),
            )));
  }

  void callFuture(LoginProvider loginProvider) async {
    await loginProvider.getTickets(context: context);
    setState(() {
      shouldCallApi = false;
    });
  }

  void _openChat(String? ticket) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chat(ticketId: ticket ?? "1")),
    );
  }

  Future<void> _incrementCounter() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTicket()),
    );
    debugPrint("here with bang _incrementCounter $shouldRefresh");
    if (shouldRefresh ?? false) {
      setState(() {
        shouldCallApi = true;
      });
    }
  }
}
