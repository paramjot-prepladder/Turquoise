import 'package:testing/generated/json/base/json_convert_content.dart';
import 'package:testing/model/login/response_login_entity.dart';

ResponseLoginEntity $ResponseLoginEntityFromJson(Map<String, dynamic> json) {
  final ResponseLoginEntity responseLoginEntity = ResponseLoginEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    responseLoginEntity.status = status;
  }
  final ResponseLoginData? data = jsonConvert.convert<ResponseLoginData>(
      json['data']);
  if (data != null) {
    responseLoginEntity.data = data;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responseLoginEntity.message = message;
  }
  return responseLoginEntity;
}

Map<String, dynamic> $ResponseLoginEntityToJson(ResponseLoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.toJson();
  data['message'] = entity.message;
  return data;
}

extension ResponseLoginEntityExtension on ResponseLoginEntity {
  ResponseLoginEntity copyWith({
    bool? status,
    ResponseLoginData? data,
    String? message,
  }) {
    return ResponseLoginEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data
      ..message = message ?? this.message;
  }
}

ResponseLoginData $ResponseLoginDataFromJson(Map<String, dynamic> json) {
  final ResponseLoginData responseLoginData = ResponseLoginData();
  final ResponseLoginDataUser? user = jsonConvert.convert<
      ResponseLoginDataUser>(json['user']);
  if (user != null) {
    responseLoginData.user = user;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    responseLoginData.token = token;
  }
  final String? tokenType = jsonConvert.convert<String>(json['token_type']);
  if (tokenType != null) {
    responseLoginData.tokenType = tokenType;
  }
  return responseLoginData;
}

Map<String, dynamic> $ResponseLoginDataToJson(ResponseLoginData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user.toJson();
  data['token'] = entity.token;
  data['token_type'] = entity.tokenType;
  return data;
}

extension ResponseLoginDataExtension on ResponseLoginData {
  ResponseLoginData copyWith({
    ResponseLoginDataUser? user,
    String? token,
    String? tokenType,
  }) {
    return ResponseLoginData()
      ..user = user ?? this.user
      ..token = token ?? this.token
      ..tokenType = tokenType ?? this.tokenType;
  }
}

ResponseLoginDataUser $ResponseLoginDataUserFromJson(
    Map<String, dynamic> json) {
  final ResponseLoginDataUser responseLoginDataUser = ResponseLoginDataUser();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    responseLoginDataUser.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    responseLoginDataUser.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    responseLoginDataUser.email = email;
  }
  return responseLoginDataUser;
}

Map<String, dynamic> $ResponseLoginDataUserToJson(
    ResponseLoginDataUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['email'] = entity.email;
  return data;
}

extension ResponseLoginDataUserExtension on ResponseLoginDataUser {
  ResponseLoginDataUser copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return ResponseLoginDataUser()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..email = email ?? this.email;
  }
}