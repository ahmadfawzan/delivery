

class ShopsList {
  final String image;
  final String shop_name_en;
  final String address;
  final int rating;
  final int total_rating;
  final int category_id;

  const ShopsList({
    required this.image,
    required this.shop_name_en,
    required this.address,
    required this.rating,
    required this.total_rating,
    required this.category_id,
  });

  factory ShopsList.fromJson(Map<String, dynamic> json) {
    return ShopsList(
      image: json['avatar_url'],
      shop_name_en: json['shop_name_en'],
      address: json['address'],
      rating: json['rating'],
      total_rating: json['total_rating'],
      category_id: json['category_id'],

    );
  }
}