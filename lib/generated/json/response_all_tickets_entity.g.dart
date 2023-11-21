import 'package:testing/generated/json/base/json_convert_content.dart';
import 'package:testing/model/tickets/response_all_tickets_entity.dart';

ResponseAllTicketsEntity $ResponseAllTicketsEntityFromJson(
    Map<String, dynamic> json) {
  final ResponseAllTicketsEntity responseAllTicketsEntity = ResponseAllTicketsEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    responseAllTicketsEntity.status = status;
  }
  final ResponseAllTicketsData? data = jsonConvert.convert<
      ResponseAllTicketsData>(json['data']);
  if (data != null) {
    responseAllTicketsEntity.data = data;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responseAllTicketsEntity.message = message;
  }
  return responseAllTicketsEntity;
}

Map<String, dynamic> $ResponseAllTicketsEntityToJson(
    ResponseAllTicketsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.toJson();
  data['message'] = entity.message;
  return data;
}

extension ResponseAllTicketsEntityExtension on ResponseAllTicketsEntity {
  ResponseAllTicketsEntity copyWith({
    bool? status,
    ResponseAllTicketsData? data,
    String? message,
  }) {
    return ResponseAllTicketsEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data
      ..message = message ?? this.message;
  }
}

ResponseAllTicketsData $ResponseAllTicketsDataFromJson(
    Map<String, dynamic> json) {
  final ResponseAllTicketsData responseAllTicketsData = ResponseAllTicketsData();
  final List<ResponseAllTicketsDataTicket>? ticket = (json['ticket'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ResponseAllTicketsDataTicket>(
          e) as ResponseAllTicketsDataTicket).toList();
  if (ticket != null) {
    responseAllTicketsData.ticket = ticket;
  }
  return responseAllTicketsData;
}

Map<String, dynamic> $ResponseAllTicketsDataToJson(
    ResponseAllTicketsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ticket'] = entity.ticket.map((v) => v.toJson()).toList();
  return data;
}

extension ResponseAllTicketsDataExtension on ResponseAllTicketsData {
  ResponseAllTicketsData copyWith({
    List<ResponseAllTicketsDataTicket>? ticket,
  }) {
    return ResponseAllTicketsData()
      ..ticket = ticket ?? this.ticket;
  }
}

ResponseAllTicketsDataTicket $ResponseAllTicketsDataTicketFromJson(
    Map<String, dynamic> json) {
  final ResponseAllTicketsDataTicket responseAllTicketsDataTicket = ResponseAllTicketsDataTicket();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    responseAllTicketsDataTicket.id = id;
  }
  final int? productId = jsonConvert.convert<int>(json['product_id']);
  if (productId != null) {
    responseAllTicketsDataTicket.productId = productId;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    responseAllTicketsDataTicket.userId = userId;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    responseAllTicketsDataTicket.type = type;
  }
  final dynamic ticketStatus = json['ticket_status'];
  if (ticketStatus != null) {
    responseAllTicketsDataTicket.ticketStatus = ticketStatus;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    responseAllTicketsDataTicket.status = status;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    responseAllTicketsDataTicket.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    responseAllTicketsDataTicket.updatedAt = updatedAt;
  }
  return responseAllTicketsDataTicket;
}

Map<String, dynamic> $ResponseAllTicketsDataTicketToJson(
    ResponseAllTicketsDataTicket entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['user_id'] = entity.userId;
  data['type'] = entity.type;
  data['ticket_status'] = entity.ticketStatus;
  data['status'] = entity.status;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension ResponseAllTicketsDataTicketExtension on ResponseAllTicketsDataTicket {
  ResponseAllTicketsDataTicket copyWith({
    int? id,
    int? productId,
    int? userId,
    String? type,
    dynamic ticketStatus,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ResponseAllTicketsDataTicket()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..userId = userId ?? this.userId
      ..type = type ?? this.type
      ..ticketStatus = ticketStatus ?? this.ticketStatus
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}