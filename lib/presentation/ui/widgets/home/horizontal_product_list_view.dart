import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      separatorBuilder: (_,__){
        return const SizedBox(width: 8);
      },
      itemBuilder: (context,index){
        return const ProductCard();
      },
    );
  }
}