import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/model/chat/response_message_entity.dart';
import 'package:testing/model/login/response_login_entity.dart';
import 'package:testing/model/tickets/response_all_tickets_entity.dart';

import '../model/category/response_category_entity.dart';
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
  ResponseCategoryEntity? listCategory;

  menuApi({required BuildContext context}) async {
    listProduct = await ApiService().productList();
    print("refresh hoja1");
    notifyListeners();
  }
  categoryRequest({required BuildContext context}) async {
    listCategory = await ApiService().categoryList();
    notifyListeners();
  }

  ResponseAllTicketsEntity? allTicketsEntity;
  ResponsePEntity? forgotResponse;
  List<ResponseAllTicketsDataTicket>? ticket;

  getTickets({required BuildContext context}) async {
    allTicketsEntity = await ApiService().getTicket();
    ticket = allTicketsEntity?.data.ticket;
    notifyListeners();
  }

  forgotPassword(String forgotPassword, {required BuildContext context}) async {
    forgotResponse = await ApiService().forgotPassword(forgotPassword);
    notifyListeners();
  }

  ResponseMessageEntity? messageEntity;
  List<ResponseMessageDataMessages>? message;

  getMessages(String ticketId, {required BuildContext context}) async {
    messageEntity = await ApiService().getMessages(ticketId);
    message = messageEntity?.data.messages;
    notifyListeners();
  }

  sendMessages(String ticketId, String mess,
      {required BuildContext context}) async {
    messageEntity = await ApiService().sendMessages(ticketId, mess);
    message = messageEntity?.data.messages;
    notifyListeners();
  }

  Future<ResponsePEntity?> productApi({required BuildContext context}) async {
    return ApiService().productList();
  }

   product({required BuildContext context}) async {
    listProduct = await ApiService().product();
    notifyListeners();
  }

  Future<ResponseMessageEntity?> createTicket(Map<String, String> body,
      {required BuildContext context}) async {
    return ApiService().createTicket(body);
  }
  Future<ResponseMessageEntity?> addProduct(Map<String, String> body,
      {required BuildContext context}) async {
    return ApiService().addProduct(body);
  }

  Future<ResponseLoginEntity?> registerUser(Map<String, String> body,
      {required BuildContext context}) async {
    return ApiService().registerUser(body);
  }

  Future<ResponseLoginEntity?> registerDeviceId(Map<String, String> body,
      {required BuildContext context}) async {
    return ApiService().registerDeviceId(body);
  }

  Future<ResponseMessageEntity?> changePassword(Map<String, String> body,
      {required BuildContext context}) async {
    return ApiService().changePassword(body);
  }
}
