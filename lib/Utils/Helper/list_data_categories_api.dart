class Categories {
  final String title;
  final String image;

  const Categories({
    required this.image,
    required this.title,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      image: json['image_url'],
      title: json['title']['en'],
    );
  }
}
