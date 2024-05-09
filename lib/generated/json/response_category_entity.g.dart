import 'package:testing/generated/json/base/json_convert_content.dart';
import 'package:testing/model/category/response_category_entity.dart';

ResponseCategoryEntity $ResponseCategoryEntityFromJson(
    Map<String, dynamic> json) {
  final ResponseCategoryEntity responseCategoryEntity = ResponseCategoryEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    responseCategoryEntity.status = status;
  }
  final ResponseCategoryData? data = jsonConvert.convert<ResponseCategoryData>(
      json['data']);
  if (data != null) {
    responseCategoryEntity.data = data;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responseCategoryEntity.message = message;
  }
  return responseCategoryEntity;
}

Map<String, dynamic> $ResponseCategoryEntityToJson(
    ResponseCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.toJson();
  data['message'] = entity.message;
  return data;
}

extension ResponseCategoryEntityExtension on ResponseCategoryEntity {
  ResponseCategoryEntity copyWith({
    bool? status,
    ResponseCategoryData? data,
    String? message,
  }) {
    return ResponseCategoryEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data
      ..message = message ?? this.message;
  }
}

ResponseCategoryData $ResponseCategoryDataFromJson(Map<String, dynamic> json) {
  final ResponseCategoryData responseCategoryData = ResponseCategoryData();
  final List<
      ResponseCategoryDataCategories>? categories = (json['categories'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ResponseCategoryDataCategories>(
          e) as ResponseCategoryDataCategories).toList();
  if (categories != null) {
    responseCategoryData.categories = categories;
  }
  return responseCategoryData;
}

Map<String, dynamic> $ResponseCategoryDataToJson(ResponseCategoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['categories'] = entity.categories.map((v) => v.toJson()).toList();
  return data;
}

extension ResponseCategoryDataExtension on ResponseCategoryData {
  ResponseCategoryData copyWith({
    List<ResponseCategoryDataCategories>? categories,
  }) {
    return ResponseCategoryData()
      ..categories = categories ?? this.categories;
  }
}

ResponseCategoryDataCategories $ResponseCategoryDataCategoriesFromJson(
    Map<String, dynamic> json) {
  final ResponseCategoryDataCategories responseCategoryDataCategories = ResponseCategoryDataCategories();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    responseCategoryDataCategories.id = id;
  }
  final String? redirectUrl = jsonConvert.convert<String>(json['redirect_url']);
  if (redirectUrl != null) {
    responseCategoryDataCategories.redirectUrl = redirectUrl;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    responseCategoryDataCategories.name = name;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    responseCategoryDataCategories.image = image;
  }
  return responseCategoryDataCategories;
}

Map<String, dynamic> $ResponseCategoryDataCategoriesToJson(
    ResponseCategoryDataCategories entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['redirect_url'] = entity.redirectUrl;
  data['name'] = entity.name;
  data['image'] = entity.image;
  return data;
}

extension ResponseCategoryDataCategoriesExtension on ResponseCategoryDataCategories {
  ResponseCategoryDataCategories copyWith({
    int? id,
    String? redirectUrl,
    String? name,
    String? image,
  }) {
    return ResponseCategoryDataCategories()
      ..id = id ?? this.id
      ..redirectUrl = redirectUrl ?? this.redirectUrl
      ..name = name ?? this.name
      ..image = image ?? this.image;
  }
}