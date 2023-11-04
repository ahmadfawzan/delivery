// To parse this JSON data, do
//
//     final shop = shopFromJson(jsonString);

import 'dart:convert';

List<Shop> shopFromJson(List<dynamic> list) => List<Shop>.from(list.map((x) => Shop.fromJson(x)));

String shopToJson(List<Shop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shop {
  int? id;
  String? nameEn;
  String? nameAr;
  String? email;
  String? mobile;
  int? mobileVerified;
  String? avatarUrl;
  String? license;
  int? isApproval;
  String? shopNameEn;
  String? shopNameAr;
  String? barcode;
  double? latitude;
  double? longitude;
  String? address;
  int? rating;
  int? deliveryRange;
  int? totalRating;
  int? defaultTax;
  int? availableForDelivery;
  int? open;
  int? categoryId;
  double? distance;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shop({
    this.id,
    this.nameEn,
    this.nameAr,
    this.email,
    this.mobile,
    this.mobileVerified,
    this.avatarUrl,
    this.license,
    this.isApproval,
    this.shopNameEn,
    this.shopNameAr,
    this.barcode,
    this.latitude,
    this.longitude,
    this.address,
    this.rating,
    this.deliveryRange,
    this.totalRating,
    this.defaultTax,
    this.availableForDelivery,
    this.open,
    this.categoryId,
    this.distance,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    email: json["email"],
    mobile: json["mobile"],
    mobileVerified: json["mobile_verified"],
    avatarUrl: json["avatar_url"],
    license: json["license"],
    isApproval: json["is_approval"],
    shopNameEn: json["shop_name_en"],
    shopNameAr: json["shop_name_ar"],
    barcode: json["barcode"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    address: json["address"],
    rating: json["rating"],
    deliveryRange: json["delivery_range"],
    totalRating: json["total_rating"],
    defaultTax: json["default_tax"],
    availableForDelivery: json["available_for_delivery"],
    open: json["open"],
    categoryId: json["category_id"],
    distance: json["distance"].toDouble(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_ar": nameAr,
    "email": email,
    "mobile": mobile,
    "mobile_verified": mobileVerified,
    "avatar_url": avatarUrl,
    "license": license,
    "is_approval": isApproval,
    "shop_name_en": shopNameEn,
    "shop_name_ar": shopNameAr,
    "barcode": barcode,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "rating": rating,
    "delivery_range": deliveryRange,
    "total_rating": totalRating,
    "default_tax": defaultTax,
    "available_for_delivery": availableForDelivery,
    "open": open,
    "category_id": categoryId,
    "distance": distance,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
