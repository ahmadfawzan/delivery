import 'dart:convert';

List<Categories> categoriesFromJson(List<dynamic> list) => List<Categories>.from(list.map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  int? id;
  Description? title;
  Description? description;
  double? commesion;
  String? imageUrl;
  String? type;
  int? deliveryFee;
  String? expeditedFees;
  String? schedulerFees;
  String? startWorkTime;
  String? endWorkTime;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  Categories({
    this.id,
    this.title,
    this.description,
    this.commesion,
    this.imageUrl,
    this.type,
    this.deliveryFee,
    this.expeditedFees,
    this.schedulerFees,
    this.startWorkTime,
    this.endWorkTime,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    title: Description.fromJson(json["title"]),
    description: Description.fromJson(json["description"]),
    commesion: json["commesion"].toDouble(),
    imageUrl: json["image_url"],
    type: json["type"],
    deliveryFee: json["delivery_fee"],
    expeditedFees: json["expedited_fees"],
    schedulerFees: json["scheduler_fees"],
    startWorkTime: json["start_work_time"],
    endWorkTime: json["end_work_time"],
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title?.toJson(),
    "description": description?.toJson(),
    "commesion": commesion,
    "image_url": imageUrl,
    "type": type,
    "delivery_fee": deliveryFee,
    "expedited_fees": expeditedFees,
    "scheduler_fees": schedulerFees,
    "start_work_time": startWorkTime,
    "end_work_time": endWorkTime,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Description {
  String? en;
  String? ar;

  Description({
    this.en,
    this.ar,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}