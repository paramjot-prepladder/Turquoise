import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:testing/model/chat/response_message_entity.dart';
import 'package:testing/model/tickets/response_all_tickets_entity.dart';
import '../../generated/json/base/json_convert_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/category/response_category_entity.dart';
import '../../model/login/response_login_entity.dart';
import '../../model/product/response_p_entity.dart';
import '../../model/product/response_prod.dart';
import '../../model/response/demo_response.dart';

class ApiService {
  static final ApiService _apiProvider = ApiService._internal();

  factory ApiService() {
    return _apiProvider;
  }

  ApiService._internal();

  String menuUrl = "https://jsonplaceholder.typicode.com/posts";
  String loginUrl = "https://reqres.in/api/login";
  String baseUrl = "https://turquoise.cc/support/api/";

  Future<List<DemoResponse>?> fundCharitiesList() async {
    try {
      http.Response data = await http.get(Uri.parse(menuUrl));
      if (data.statusCode == 200) {
        List<DemoResponse> listRes = [];
        List res = jsonDecode(data.body);
        res.forEach((element) {
          listRes.add(DemoResponse.fromJson(element));
        });
        return listRes;
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponsePEntity?> productList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.get(Uri.parse("${baseUrl}products"),
          headers: {"Authorization": token.toString()});
      debugPrint("Authorization" + token.toString());
      debugPrint(data.body);
      if (data.statusCode == 200) {
        debugPrint('movieTitle: ${data.body}');

        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponsePEntity?> product() async {
    try {

      http.Response data = await http.get(Uri.parse("${baseUrl}product"));
      debugPrint(data.body);
      if (data.statusCode == 200) {
        debugPrint('movieTitle123: ${data.body}');

        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseCategoryEntity?> categoryList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.get(Uri.parse("${baseUrl}categories"),
          headers: {"Authorization": token.toString()});
      debugPrint("Authorization" + token.toString());
      debugPrint(data.body);
      if (data.statusCode == 200) {
        debugPrint('movieTitle: ${data.body}');

        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponsePEntity?> forgotPassword(String email) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, String> body = Map();
      body['email'] = email;
      http.Response data = await http.post(
          Uri.parse("${baseUrl}forgot-password"),
          body: body,
          headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        debugPrint('movieTitle: ${data.body}');

        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseAllTicketsEntity?> getTicket() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.get(Uri.parse("${baseUrl}ticket"),
          headers: {"Authorization": token.toString()});
      debugPrint(data.request?.url.toString());
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseMessageEntity?> getMessages(String ticketId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.get(
          Uri.parse("${baseUrl}message?ticket_id=$ticketId"),
          headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseMessageEntity?> createTicket(Map<String, String> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.post(Uri.parse("${baseUrl}ticket"),
          body: body, headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }
  Future<ResponseMessageEntity?> addProduct(Map<String, String> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.post(Uri.parse("${baseUrl}product"),
          body: body, headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseMessageEntity?> changePassword(
      Map<String, String> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.post(
          Uri.parse("${baseUrl}change-password"),
          body: body,
          headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseLoginEntity?> registerUser(Map<String, String> body) async {
    try {
      http.Response data =
          await http.post(Uri.parse("${baseUrl}register"), body: body);
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseLoginEntity?> registerDeviceId(
      Map<String, String> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.post(Uri.parse("${baseUrl}device-id"),
          body: body, headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseMessageEntity?> sendMessages(
      String ticketId, String message) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, String> body = Map();
      body['ticket_id'] = ticketId;
      body['message'] = message;
      http.Response data = await http.post(Uri.parse("${baseUrl}message"),
          body: body, headers: {"Authorization": token.toString()});
      debugPrint(data.body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseLoginEntity?> loginApi(
      {required String email, required String pwd}) async {
    try {
      Map<String, String> body = Map();
      body['email'] = email;
      body['password'] = pwd;
      http.Response data =
          await http.post(Uri.parse("${baseUrl}login"), body: body);
      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
