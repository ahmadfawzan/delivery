class Address {
  final String longitude;
  final String latitude;
  final String street;
  final String name;
  final String city;
  final String building_number;
  final int type;

  const Address({
    required this.longitude,
    required this.latitude,
    required this.street,
    required this.name,
    required this.city,
    required this.building_number,
    required this.type,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      longitude: json['longitude']??'',
      latitude: json['latitude']??'',
      street: json['street']??'',
      name: json['name']??'',
      city: json['city']??'',
      building_number: json['building_number']??'',
      type: json['type']??'',
    );
  }
}
