class ShopsList {
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
  String? createdAt;
  String? updatedAt;

  ShopsList(
      {this.id,
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
        this.updatedAt});

  ShopsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    email = json['email'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    avatarUrl = json['avatar_url'];
    license = json['license'];
    isApproval = json['is_approval'];
    shopNameEn = json['shop_name_en'];
    shopNameAr = json['shop_name_ar'];
    barcode = json['barcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    rating = json['rating'];
    deliveryRange = json['delivery_range'];
    totalRating = json['total_rating'];
    defaultTax = json['default_tax'];
    availableForDelivery = json['available_for_delivery'];
    open = json['open'];
    categoryId = json['category_id'];
    distance = json['distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['mobile_verified'] = this.mobileVerified;
    data['avatar_url'] = this.avatarUrl;
    data['license'] = this.license;
    data['is_approval'] = this.isApproval;
    data['shop_name_en'] = this.shopNameEn;
    data['shop_name_ar'] = this.shopNameAr;
    data['barcode'] = this.barcode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['delivery_range'] = this.deliveryRange;
    data['total_rating'] = this.totalRating;
    data['default_tax'] = this.defaultTax;
    data['available_for_delivery'] = this.availableForDelivery;
    data['open'] = this.open;
    data['category_id'] = this.categoryId;
    data['distance'] = this.distance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}