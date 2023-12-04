import 'package:testing/generated/json/base/json_convert_content.dart';
import 'package:testing/model/chat/response_message_entity.dart';

ResponseMessageEntity $ResponseMessageEntityFromJson(
    Map<String, dynamic> json) {
  final ResponseMessageEntity responseMessageEntity = ResponseMessageEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    responseMessageEntity.status = status;
  }
  final ResponseMessageData? data =
      jsonConvert.convert<ResponseMessageData>(json['data']);
  if (data != null) {
    responseMessageEntity.data = data;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responseMessageEntity.message = message;
  }
  return responseMessageEntity;
}

Map<String, dynamic> $ResponseMessageEntityToJson(
    ResponseMessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.toJson();
  data['message'] = entity.message;
  return data;
}

extension ResponseMessageEntityExtension on ResponseMessageEntity {
  ResponseMessageEntity copyWith({
    bool? status,
    ResponseMessageData? data,
    String? message,
  }) {
    return ResponseMessageEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data
      ..message = message ?? this.message;
  }
}

ResponseMessageData $ResponseMessageDataFromJson(Map<String, dynamic> json) {
  final ResponseMessageData responseMessageData = ResponseMessageData();
  final List<ResponseMessageDataMessages>? messages =
      (json['messages'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<ResponseMessageDataMessages>(e)
              as ResponseMessageDataMessages)
          .toList();
  if (messages != null) {
    responseMessageData.messages = messages;
  }
  return responseMessageData;
}

Map<String, dynamic> $ResponseMessageDataToJson(ResponseMessageData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['messages'] = entity.messages.map((v) => v.toJson()).toList();
  return data;
}

extension ResponseMessageDataExtension on ResponseMessageData {
  ResponseMessageData copyWith({
    List<ResponseMessageDataMessages>? messages,
  }) {
    return ResponseMessageData()..messages = messages ?? this.messages;
  }
}

ResponseMessageDataMessages $ResponseMessageDataMessagesFromJson(
    Map<String, dynamic> json) {
  final ResponseMessageDataMessages responseMessageDataMessages =
      ResponseMessageDataMessages();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    responseMessageDataMessages.id = id;
  }
  final int? ticketId = jsonConvert.convert<int>(json['ticket_id']);
  if (ticketId != null) {
    responseMessageDataMessages.ticketId = ticketId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responseMessageDataMessages.message = message;
  }
  final String? isRead = jsonConvert.convert<String>(json['is_read']);
  if (isRead != null) {
    responseMessageDataMessages.isRead = isRead;
  }
  final dynamic isAdmin = json['is_admin'];
  if (isAdmin != null) {
    responseMessageDataMessages.isAdmin = isAdmin;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    responseMessageDataMessages.status = status;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    responseMessageDataMessages.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    responseMessageDataMessages.updatedAt = updatedAt;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    responseMessageDataMessages.time = time;
  }
  return responseMessageDataMessages;
}

Map<String, dynamic> $ResponseMessageDataMessagesToJson(
    ResponseMessageDataMessages entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ticket_id'] = entity.ticketId;
  data['message'] = entity.message;
  data['is_read'] = entity.isRead;
  data['is_admin'] = entity.isAdmin;
  data['status'] = entity.status;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['time'] = entity.time;
  return data;
}

extension ResponseMessageDataMessagesExtension on ResponseMessageDataMessages {
  ResponseMessageDataMessages copyWith({
    int? id,
    int? ticketId,
    String? message,
    String? isRead,
    dynamic isAdmin,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? time,
  }) {
    return ResponseMessageDataMessages()
      ..id = id ?? this.id
      ..ticketId = ticketId ?? this.ticketId
      ..message = message ?? this.message
      ..isRead = isRead ?? this.isRead
      ..isAdmin = isAdmin ?? this.isAdmin
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..time = time ?? this.time;
  }
}
