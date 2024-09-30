import 'package:crafty_bay/data/models/category_model.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';

class HorizontalCategoryListView extends StatelessWidget {
  final List<CategoryModel> categoryList;

  const HorizontalCategoryListView({
    super.key,
    required this.categoryList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length,
      separatorBuilder: (_,__){
        return const SizedBox(width: 8);
      },
      itemBuilder: (context,index){
        return  CategoryCard(
          categoryModel:categoryList[index],
        );
      },
    );
  }
}

