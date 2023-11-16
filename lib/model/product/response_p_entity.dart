
import 'dart:convert';

import '../../generated/json/base/json_field.dart';
import '../../generated/json/response_p_entity.g.dart';
export '../../generated/json/response_p_entity.g.dart';

@JsonSerializable()
class ResponsePEntity {
	late bool status;
	late ResponsePData data;
	late String message;

	ResponsePEntity();

	factory ResponsePEntity.fromJson(Map<String, dynamic> json) => $ResponsePEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponsePEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponsePData {
	late List<ResponsePDataProducts> products;

	ResponsePData();

	factory ResponsePData.fromJson(Map<String, dynamic> json) => $ResponsePDataFromJson(json);

	Map<String, dynamic> toJson() => $ResponsePDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponsePDataProducts {
	late int id;
	late String name;
	dynamic slug;
	late String summary;
	late String description;
	dynamic price;
	late String sku;
	late String image;
	late int status;
	@JSONField(name: "deleted_at")
	dynamic deletedAt;
	@JSONField(name: "created_at")
	late String createdAt;
	@JSONField(name: "updated_at")
	late String updatedAt;

	ResponsePDataProducts();

	factory ResponsePDataProducts.fromJson(Map<String, dynamic> json) => $ResponsePDataProductsFromJson(json);

	Map<String, dynamic> toJson() => $ResponsePDataProductsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}