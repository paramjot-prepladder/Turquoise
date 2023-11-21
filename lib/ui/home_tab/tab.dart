import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/ui/register/register.dart';

import '../chat/chat.dart';
import '../menu/menu.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabHome();
  }
}

class _TabHome extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [MenuScreen(), Chat()],
          ),
        ),
      ),
    );
  }
}
