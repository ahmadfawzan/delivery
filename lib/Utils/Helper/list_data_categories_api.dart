class Categories {
  final String title;
  final String image;
  final int id;
  const Categories({
    required this.image,
    required this.title,
    required this.id,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      image: json['image_url']??'',
      title: json['title']['en']??'',
      id: json['id']??'',
    );

  }

}
