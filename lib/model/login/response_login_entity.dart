import '../../generated/json/base/json_field.dart';
import '../../generated/json/response_login_entity.g.dart';
import 'dart:convert';
export '../../generated/json/response_login_entity.g.dart';

@JsonSerializable()
class ResponseLoginEntity {
	late bool status;
	late ResponseLoginData data;
	late String message;

	ResponseLoginEntity();

	factory ResponseLoginEntity.fromJson(Map<String, dynamic> json) => $ResponseLoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponseLoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseLoginData {
	late ResponseLoginDataUser user;
	late String token;
	late String tokenType;

	ResponseLoginData();

	factory ResponseLoginData.fromJson(Map<String, dynamic> json) => $ResponseLoginDataFromJson(json);

	Map<String, dynamic> toJson() => $ResponseLoginDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseLoginDataUser {
	late int id;
	late String name;
	late String email;


	ResponseLoginDataUser();

	factory ResponseLoginDataUser.fromJson(Map<String, dynamic> json) => $ResponseLoginDataUserFromJson(json);

	Map<String, dynamic> toJson() => $ResponseLoginDataUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}