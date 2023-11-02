// To parse this JSON data, do
//
//     final addresses = addressesFromJson(jsonString);

import 'dart:convert';

List<Addresses> addressesFromJson(List<dynamic> list) => List<Addresses>.from(list.map((x) => Addresses.fromJson(x)));

String addressesToJson(List<Addresses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Addresses {
  int? id;
  String? longitude;
  String? latitude;
  int? distance;
  String? name;
  String? street;
  String? buildingNumber;
  String? city;
  int? addressDefault;
  int? apartmentNum;
  int? active;
  int? type;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Addresses({
    this.id,
    this.longitude,
    this.latitude,
    this.distance,
    this.name,
    this.street,
    this.buildingNumber,
    this.city,
    this.addressDefault,
    this.apartmentNum,
    this.active,
    this.type,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
    id: json["id"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    distance: json["distance"],
    name: json["name"],
    street: json["street"],
    buildingNumber: json["building_number"],
    city: json["city"],
    addressDefault: json["default"],
    apartmentNum: json["apartment_num"],
    active: json["active"],
    type: json["type"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "longitude": longitude,
    "latitude": latitude,
    "distance": distance,
    "name": name,
    "street": street,
    "building_number": buildingNumber,
    "city": city,
    "default": addressDefault,
    "apartment_num": apartmentNum,
    "active": active,
    "type": type,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
