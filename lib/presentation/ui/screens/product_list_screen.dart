import 'package:crafty_bay/data/models/category_model.dart';
import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  final CategoryModel category;

  const ProductListScreen({
    super.key,
    required this.category,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductListByCategory(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.category.categoryName ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GetBuilder<ProductListByCategoryController>(
          builder: (productListByCategoryController) {
            if (productListByCategoryController.inProgress) {
              return const CenteredCircularProgressIndicator();
            }

            if (productListByCategoryController.errorMessage != null) {
              return Center(
                child: Text(productListByCategoryController.errorMessage!),
              );
            }

            if (productListByCategoryController.productList.isEmpty) {
              return const Center(
                child: Text('Empty product list..!'),
              );
            }
            return GridView.builder(
                itemCount: productListByCategoryController.productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context,index){
                  return  ProductCard(
                    product: productListByCategoryController.productList[index],
                  );
                },
            );
          }
        ),
      ),
    );
  }
}
