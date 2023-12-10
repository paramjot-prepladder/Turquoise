import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testing/model/chat/response_message_entity.dart';
import 'package:testing/utils/common/common_widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../provider/login_provider.dart';
import '../../utils/color/app_colors.dart';
import '../../utils/common/text_field.dart';

class Chat extends StatefulWidget {
  final String ticketId;

  const Chat({super.key, required this.ticketId});

  @override
  State<StatefulWidget> createState() => _ChatState(ticketId);
}

final items = List<MessageTile>.generate(
  10,
  (i) => MessageTile(
      message: "message $i", sendByMe: i % 2 == 0, time: "2 hours ago"),
);

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  final String ticket;
  var _isLoading = false;
  Timer? timer;
  double visiblePercentage = 100;
  final ScrollController _controller = ScrollController();
  bool shouldCallApi = true;

  _ChatState(this.ticket);

  late TextEditingController _messageCtrl;
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _messageCtrl = TextEditingController();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("here with bang dispose ${state}");
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("resumed");
        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        debugPrint("inactive");
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        debugPrint("paused");
        // widget is paused
        break;
      case AppLifecycleState.detached:
        debugPrint("detached");
        // widget is detached
        break;
      case AppLifecycleState.hidden:
        debugPrint("hidden");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Timer(const Duration(milliseconds: 500), () => _scrollDown());
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    if (_keyboardVisible) {
      _scrollDown();
    }
    debugPrint(_keyboardVisible.toString());
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: AppColors.greenPrimary,
                title: const Text('Messages'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    tooltip: "Refresh Chat",
                    onPressed: () {
                      setState(() {
                        shouldCallApi = true;
                      });
                    },
                  ),
                ]),
            backgroundColor: AppColors.whiteText,
            body: Consumer<LoginProvider>(
              builder: (context, loginProvider, child) {
                if (shouldCallApi) {
                  callFuture(loginProvider);
                }
                return Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: loginProvider.message != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: _controller,
                              itemCount: loginProvider.message?.length,
                              itemBuilder: (context, index) {
                                return VisibilityDetector(
                                    key: const Key('main'),
                                    onVisibilityChanged: (visibilityInfo) {
                                      visiblePercentage =
                                          visibilityInfo.visibleFraction * 100;
                                      debugPrint(
                                          'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                                    },
                                    child: MessageTile(
                                      message:
                                          loginProvider.message![index].message,
                                      sendByMe: loginProvider
                                                  .message![index].isAdmin ==
                                              "1"
                                          ? false
                                          : true,
                                      time: loginProvider.message![index].time,
                                    ));
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.greenPrimary,
                              ),
                            ),
                    )),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                hintText: 'Message to send',
                              ),
                              controller: _messageCtrl,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: button(
                            text: "Send",
                            onTap: () {
                              _sendChat(loginProvider);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            )));
  }

  void callFuture(LoginProvider loginProvider) async {
    timer?.cancel();
    await loginProvider.getMessages(ticket, context: context);
    setState(() {
      shouldCallApi = false;
    });
    if (visiblePercentage == 100) {
      _scrollDown();
    }
    refreshChat();
  }

  _sendChat(LoginProvider loginProvider) async {
    setState(() => _isLoading = true);
    if (_messageCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter message to send.",
        ),
      );
    }
    await loginProvider.sendMessages(ticket, _messageCtrl.text,
        context: context);
    setState(() => _isLoading = false);
    _messageCtrl.clear();
    scrollToBottom(_controller);
  }

  Future scrollToBottom(ScrollController scrollController) async {
    while (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      await SchedulerBinding.instance!.endOfFrame;
    }
  }

  void refreshChat() {
    timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        shouldCallApi = true;
      });
    });
  }

  void _scrollToPosition(int pos) {
    // _controller.jumpTo(pos);
  }

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToBottom(_controller);
    });

    // _controller.jumpTo(_controller.position.maxScrollExtent);
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final String time;
  final bool sendByMe;

  const MessageTile(
      {super.key,
      required this.message,
      required this.sendByMe,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: sendByMe
                  ? const EdgeInsets.only(left: 30)
                  : const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.only(
                  top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: sendByMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomLeft: Radius.circular(23))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomRight: Radius.circular(23)),
                  gradient: LinearGradient(
                    colors: sendByMe
                        ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                        : [const Color(0xff22534f), const Color(0xff22534F)],
                  )),
              child: Text(message,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(time,
                  style:
                      const TextStyle(color: AppColors.greyText, fontSize: 10)),
            )
          ],
        ));
  }
}
