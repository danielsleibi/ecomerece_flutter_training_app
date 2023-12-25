import 'package:ecommerce_task/models/category_model.dart';
import 'package:ecommerce_task/pages/category_products_page.dart';
import 'package:ecommerce_task/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.categoryList});
  final List<CategoryModel> categoryList;
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  Widget buildSearchBar(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 10.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes the shadow direction
                ),
              ],
            ),
            child: SizedBox(
                height: 50.0,
                child: TextField(
                    decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search Product',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.purple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                )))),
      ),
    );
  }

  Widget buildCategorySection(
      BuildContext context, List<CategoryModel> categories, String title) {
    return ListView.builder(
        itemBuilder: (context, index) {
          if (index * 2 >= categories.length) {
            return Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Row(children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryProductPage(
                                catId: categories[index].id ?? -1,
                              ),
                            ));
                      },
                      child: CategoryCard(
                        name: categories[index].name ?? 'Failed to load name',
                        imageURL: categories[index].image ?? '',
                        isSized: false,
                      ),
                    ),
                  )
                ]));
          }
          String? name = categories[index * 2].name;
          String imageURL = categories[index * 2].image ?? '';
          String name2 = '';
          String imageURL2 = '';
          if ((index * 2 + 1) < categories.length) {
            name2 = categories[index * 2 + 1].name!;
            imageURL2 = categories[index * 2 + 1].image ?? '';
          }

          return Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryProductPage(
                                catId: categories[index * 2].id ?? -1,
                              ),
                            ));
                      },
                      child: CategoryCard(
                        name: name ?? 'Failed to load',
                        imageURL: imageURL,
                        isSized: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryProductPage(
                                catId: categories[index * 2 + 1].id ?? -1,
                              ),
                            ));
                      },
                      child: CategoryCard(
                        name: name2,
                        imageURL: imageURL2,
                        isSized: false,
                      ),
                    ),
                  ),
                ],
              ));
        },
        itemCount: (categories.length / 2).ceil());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 35.0),
        child: Row(
          children: [
            buildSearchBar(context),
          ],
        ),
      ),
      Expanded(
          child: buildCategorySection(
              context, widget.categoryList, 'Special for you'))
    ]);
  }
}
