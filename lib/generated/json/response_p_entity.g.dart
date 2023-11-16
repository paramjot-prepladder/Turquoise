import '../../model/product/response_p_entity.dart';
import 'base/json_convert_content.dart';

ResponsePEntity $ResponsePEntityFromJson(Map<String, dynamic> json) {
  final ResponsePEntity responsePEntity = ResponsePEntity();
  final bool? status = jsonConvert.convert<bool>(json['status']);
  if (status != null) {
    responsePEntity.status = status;
  }
  final ResponsePData? data = jsonConvert.convert<ResponsePData>(json['data']);
  if (data != null) {
    responsePEntity.data = data;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responsePEntity.message = message;
  }
  return responsePEntity;
}

Map<String, dynamic> $ResponsePEntityToJson(ResponsePEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data.toJson();
  data['message'] = entity.message;
  return data;
}

extension ResponsePEntityExtension on ResponsePEntity {
  ResponsePEntity copyWith({
    bool? status,
    ResponsePData? data,
    String? message,
  }) {
    return ResponsePEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data
      ..message = message ?? this.message;
  }
}

ResponsePData $ResponsePDataFromJson(Map<String, dynamic> json) {
  final ResponsePData responsePData = ResponsePData();
  final List<ResponsePDataProducts>? products = (json['products'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ResponsePDataProducts>(e) as ResponsePDataProducts)
      .toList();
  if (products != null) {
    responsePData.products = products;
  }
  return responsePData;
}

Map<String, dynamic> $ResponsePDataToJson(ResponsePData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['products'] = entity.products.map((v) => v.toJson()).toList();
  return data;
}

extension ResponsePDataExtension on ResponsePData {
  ResponsePData copyWith({
    List<ResponsePDataProducts>? products,
  }) {
    return ResponsePData()
      ..products = products ?? this.products;
  }
}

ResponsePDataProducts $ResponsePDataProductsFromJson(
    Map<String, dynamic> json) {
  final ResponsePDataProducts responsePDataProducts = ResponsePDataProducts();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    responsePDataProducts.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    responsePDataProducts.name = name;
  }
  final dynamic slug = json['slug'];
  if (slug != null) {
    responsePDataProducts.slug = slug;
  }
  final String? summary = jsonConvert.convert<String>(json['summary']);
  if (summary != null) {
    responsePDataProducts.summary = summary;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    responsePDataProducts.description = description;
  }
  final dynamic price = json['price'];
  if (price != null) {
    responsePDataProducts.price = price;
  }
  final String? sku = jsonConvert.convert<String>(json['sku']);
  if (sku != null) {
    responsePDataProducts.sku = sku;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    responsePDataProducts.image = image;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    responsePDataProducts.status = status;
  }
  final dynamic deletedAt = json['deleted_at'];
  if (deletedAt != null) {
    responsePDataProducts.deletedAt = deletedAt;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    responsePDataProducts.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    responsePDataProducts.updatedAt = updatedAt;
  }
  return responsePDataProducts;
}

Map<String, dynamic> $ResponsePDataProductsToJson(
    ResponsePDataProducts entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['slug'] = entity.slug;
  data['summary'] = entity.summary;
  data['description'] = entity.description;
  data['price'] = entity.price;
  data['sku'] = entity.sku;
  data['image'] = entity.image;
  data['status'] = entity.status;
  data['deleted_at'] = entity.deletedAt;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension ResponsePDataProductsExtension on ResponsePDataProducts {
  ResponsePDataProducts copyWith({
    int? id,
    String? name,
    dynamic slug,
    String? summary,
    String? description,
    dynamic price,
    String? sku,
    String? image,
    int? status,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    return ResponsePDataProducts()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..slug = slug ?? this.slug
      ..summary = summary ?? this.summary
      ..description = description ?? this.description
      ..price = price ?? this.price
      ..sku = sku ?? this.sku
      ..image = image ?? this.image
      ..status = status ?? this.status
      ..deletedAt = deletedAt ?? this.deletedAt
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}