import 'package:flutter/cupertino.dart';

import '../model/item.dart';

class HomeProvider extends ChangeNotifier {

  List<Item> itemList = [];

  addItem(String name) {
    Item item = Item(name);
    itemList.add(item);
    notifyListeners();
  }
}
