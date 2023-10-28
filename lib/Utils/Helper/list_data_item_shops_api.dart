
class ItemShopsList {
  final int id;
  final double price;
  final String  image_url;
  final int  is_approval;
  final int  quantity;
  final String title;
  final int shop_id;
  final String description;
  const ItemShopsList({
    required this.id,
    required this.price,
    required this.image_url,
    required this.is_approval,
    required this.quantity,
    required this.title,
    required this.description,
    required this.shop_id,
  });

  factory ItemShopsList.fromJson(Map<String, dynamic> json) {
    return ItemShopsList(
      shop_id:  json['pivot']['shop_id'] ?? '',
      id:  json['id'] ?? '',
      price: json['price'] ?? '',
      image_url: json['image_url'] ?? '',
      is_approval: json['is_approval'] ?? '',
      quantity: json['quantity'] ?? '',
      title: json['title']['en'] ?? '',
      description: json['description']['en'] ?? '',
    );
  }
}
