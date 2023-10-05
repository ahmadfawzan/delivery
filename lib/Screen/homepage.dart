import 'package:flutter/material.dart';
import '../Server/api_categories_response.dart';
import '../Utils/Helper/list_data_categories_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Categories>>(
          future: fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return categoriesList(categories: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
class categoriesList extends StatefulWidget {
  const categoriesList({super.key, required this.categories});

  final List<Categories> categories;

  @override
  State<categoriesList> createState() => _categoriesListState();
}

class _categoriesListState extends State<categoriesList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        return Text(widget.categories[index].title);
      },
    );
  }

}