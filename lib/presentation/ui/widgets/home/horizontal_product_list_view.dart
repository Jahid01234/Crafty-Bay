import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HorizontalProductListView extends StatelessWidget {
  final List<ProductModel> productList;

  const HorizontalProductListView({
    super.key,
    required this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: productList.length,
      separatorBuilder: (_,__){
        return const SizedBox(width: 8);
      },
      itemBuilder: (context,index){
        return  ProductCard(
          product: productList[index],
        );
      },
    );
  }
}