import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testing/ui/blank.dart';
import 'package:testing/ui/settings/settings.dart';
import 'package:testing/utils/color/app_colors.dart';

import '../menu/menu.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabHome();
  }
}

class _TabHome extends State<TabHome> with SingleTickerProviderStateMixin{
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: 3, vsync: this);

    _controller?.addListener(() {
      if(_controller?.index == 0){
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
      if (kDebugMode) {
        print("Selected Index: ${_controller?.index}");
      }
    });
    _controller?.animateTo(1);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.greenPrimary,
            bottom:  TabBar(
              controller: _controller,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: const [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.list_alt)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: const Text('TurQuoise',style: TextStyle(color: Colors.white),),
          ),
          body:  TabBarView(
            controller: _controller,
            children: const [Blank(),MenuScreen(), Settings()],
          ),
        ),
      ),
    );
  }
}
