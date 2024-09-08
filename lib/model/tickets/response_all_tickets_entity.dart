import 'package:testing/generated/json/base/json_field.dart';
import 'package:testing/generated/json/response_all_tickets_entity.g.dart';
import 'dart:convert';
export 'package:testing/generated/json/response_all_tickets_entity.g.dart';

@JsonSerializable()
class ResponseAllTicketsEntity {
	late bool status;
	late ResponseAllTicketsData data;
	late String message;

	ResponseAllTicketsEntity();

	factory ResponseAllTicketsEntity.fromJson(Map<String, dynamic> json) => $ResponseAllTicketsEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponseAllTicketsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseAllTicketsData {
	late List<ResponseAllTicketsDataTicket> ticket;

	ResponseAllTicketsData();

	factory ResponseAllTicketsData.fromJson(Map<String, dynamic> json) => $ResponseAllTicketsDataFromJson(json);

	Map<String, dynamic> toJson() => $ResponseAllTicketsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseAllTicketsDataTicket {
	late int id;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_name")
	late String productName;
	@JSONField(name: "user_id")
	late int userId;
	@JSONField(name: "serial_number")
	late int serialNumber;
	late String type;
	@JSONField(name: "ticket_status")
	dynamic ticketStatus;
	late int status;
	@JSONField(name: "created_at")
	late String createdAt;
	@JSONField(name: "updated_at")
	late String updatedAt;
	@JSONField(name: "time")
	late String time;
	@JSONField(name: "full_date_time")
	late String fullDateTime;
	@JSONField(name: "unread_messages")
	late String unreadMessages;

	ResponseAllTicketsDataTicket();

	factory ResponseAllTicketsDataTicket.fromJson(Map<String, dynamic> json) => $ResponseAllTicketsDataTicketFromJson(json);

	Map<String, dynamic> toJson() => $ResponseAllTicketsDataTicketToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}