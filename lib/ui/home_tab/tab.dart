import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/ui/cart/cart.dart';
import 'package:testing/ui/register/register.dart';
import 'package:testing/ui/settings/settings.dart';
import 'package:testing/utils/color/app_colors.dart';

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
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.greenPrimary,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: const Text('TurQuoise'),
          ),
          body: const TabBarView(
            children: [MenuScreen(), Settings()],
          ),
        ),
      ),
    );
  }
}
