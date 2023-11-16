import 'package:flutter/material.dart';

import '../model/response/demo_response.dart';
import '../utils/services/api_provider.dart';

class MenuProvider extends ChangeNotifier {
  
  List<DemoResponse>? demo;
  menuApi(
      {required BuildContext context}) async {
    demo = await ApiService().fundCharitiesList();
    notifyListeners();
  }
}
