import 'package:testing/generated/json/base/json_field.dart';
import 'package:testing/generated/json/response_message_entity.g.dart';
import 'dart:convert';
export 'package:testing/generated/json/response_message_entity.g.dart';

@JsonSerializable()
class ResponseMessageEntity {
	late bool status;
	late ResponseMessageData data;
	late String message;

	ResponseMessageEntity();

	factory ResponseMessageEntity.fromJson(Map<String, dynamic> json) => $ResponseMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponseMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseMessageData {
	late List<ResponseMessageDataMessages> messages;

	ResponseMessageData();

	factory ResponseMessageData.fromJson(Map<String, dynamic> json) => $ResponseMessageDataFromJson(json);

	Map<String, dynamic> toJson() => $ResponseMessageDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseMessageDataMessages {
	late int id;
	@JSONField(name: "ticket_id")
	late int ticketId;
	late String message;
	@JSONField(name: "is_read")
	late String isRead;
	@JSONField(name: "is_admin")
	dynamic isAdmin;
	late int status;
	@JSONField(name: "created_at")
	late String createdAt;
	@JSONField(name: "updated_at")
	late String updatedAt;
	@JSONField(name: "time")
	late String time;

	ResponseMessageDataMessages();

	factory ResponseMessageDataMessages.fromJson(Map<String, dynamic> json) => $ResponseMessageDataMessagesFromJson(json);

	Map<String, dynamic> toJson() => $ResponseMessageDataMessagesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}