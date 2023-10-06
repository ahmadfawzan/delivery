import 'package:delivery/Utils/Ui/image_widgets.dart';
import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/material.dart';
import '../Server/api_categories_response.dart';
import '../Utils/Helper/list_data_categories_api.dart';
import '../Utils/Ui/image_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Container(
          padding: const EdgeInsets.only(top: 40,right:18,left: 12),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed:(){MaterialLocalizations.of(context).openAppDrawerTooltip;} , icon: const Icon(Icons.menu,size: 25,)),
              IconButton(onPressed: () {  },icon:const Icon(Icons.shopping_bag,color: Color(0xff4E5156),size: 25,), )
            ],
          ),
          ),
          const SizedBox(height: 7,),
          const Padding(
            padding: EdgeInsets.only(right: 235.0),
            child: TextWidgets(text:"Delvering To",fontSize: 13,fontWeight: FontWeight.bold,color: Colors.grey,),
          ),
          SizedBox(height: 30,),
          Container(
            width: double.infinity,
            height: 122,
            child:const ImageWidget(image:'assets/images/image6.png',fit: BoxFit.cover,),
          ),
          Expanded(
            child: FutureBuilder<List<Categories>>(
              future: fetchCategories(),
              builder: (context, snapshot) {

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return categoriesList(categories: snapshot.data!);
                }
                else {
                  return const Text('');
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 55,
            color: Color(0xff15CB95),
          )
        ],
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
        return InkWell(
          onTap: (){ print(index); },
          child: Card(

              elevation: 10,
              shadowColor: Colors.black,
              child: Column(

                children: [
                ImageNetworkWidget(image: 'https://news.wasiljo.com/public/${widget.categories[index].image}',height: 120,width: double.infinity,fit: BoxFit.fitHeight,),
                SizedBox(height: 23,),
                TextWidgets(text:widget.categories[index].title, fontSize: 10, fontWeight: FontWeight.bold)
                ],
              ),
            ),
        );
      },
    );
  }

}