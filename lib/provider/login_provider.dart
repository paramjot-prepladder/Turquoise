import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/model/login/response_login_entity.dart';
import 'package:testing/model/tickets/response_all_tickets_entity.dart';

import '../model/product/response_p_entity.dart';
import '../ui/home/home.dart';
import '../utils/services/api_provider.dart';

//view model
class LoginProvider extends ChangeNotifier {
  Future<ResponseLoginEntity?> loginApi(
      {required String email,
      required String pwd,
      required BuildContext context}) async {
    var result = await ApiService().loginApi(email: email, pwd: pwd);
   return result;

  }

  ResponsePEntity? listProduct;
  List<String>? s ;
  menuApi({required BuildContext context}) async {
    listProduct = await ApiService().productList();
    var a = listProduct?.data.products.map((e) => e.name);
    s = a?.toList();
    if (kDebugMode) {
      print(a?.toList());
    }
    notifyListeners();
  }

  ResponseAllTicketsEntity? allTicketsEntity;
  List<ResponseAllTicketsDataTicket>? ticket ;
  getTickets({required BuildContext context}) async {
    allTicketsEntity = await ApiService().getTicket();
    ticket = allTicketsEntity?.data.ticket;
    notifyListeners();
  }

  Future<ResponsePEntity?> productApi({required BuildContext context}) async {
    return ApiService().productList();
  }
}
