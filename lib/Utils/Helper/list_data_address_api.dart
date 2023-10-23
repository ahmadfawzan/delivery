class Address {
  final int id;
  final String longitude;
  final String latitude;
  final String street;
  final String name;
  final String city;
  final String building_number;
  final int type;
  final int apartment_num;
  const Address({
    required this.longitude,
    required this.latitude,
    required this.street,
    required this.name,
    required this.city,
    required this.building_number,
    required this.type,
    required this.id,
    required this.apartment_num,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      street: json['street'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      building_number: json['building_number'] ?? '',
      type: json['type'] ?? '',
      apartment_num: json['apartment_num'] ?? '',
    );
  }
}
