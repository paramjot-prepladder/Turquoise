import 'package:testing/generated/json/base/json_field.dart';
import 'package:testing/generated/json/response_category_entity.g.dart';
import 'dart:convert';
export 'package:testing/generated/json/response_category_entity.g.dart';

@JsonSerializable()
class ResponseCategoryEntity {
	late bool status;
	late ResponseCategoryData data;
	late String message;

	ResponseCategoryEntity();

	factory ResponseCategoryEntity.fromJson(Map<String, dynamic> json) => $ResponseCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponseCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseCategoryData {
	late List<ResponseCategoryDataCategories> categories;

	ResponseCategoryData();

	factory ResponseCategoryData.fromJson(Map<String, dynamic> json) => $ResponseCategoryDataFromJson(json);

	Map<String, dynamic> toJson() => $ResponseCategoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResponseCategoryDataCategories {
	late int id;
	@JSONField(name: "redirect_url")
	late String redirectUrl;
	late String name;
	late String image;

	ResponseCategoryDataCategories();

	factory ResponseCategoryDataCategories.fromJson(Map<String, dynamic> json) => $ResponseCategoryDataCategoriesFromJson(json);

	Map<String, dynamic> toJson() => $ResponseCategoryDataCategoriesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}