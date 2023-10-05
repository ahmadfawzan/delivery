
class Categories {
  final String title;


  const Categories({

    required this.title,

  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(

      title: json['title']['en'] ,

    );
  }
}