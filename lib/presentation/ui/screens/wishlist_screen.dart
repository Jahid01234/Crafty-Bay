import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title:  const Text("WishList"),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GetBuilder<WishListController>(
            builder: (wishListController) {
              if (wishListController.inProgress) {
                return const CenteredCircularProgressIndicator();
              }

              if (wishListController.errorMessage != null) {
                return Center(
                  child: Text(wishListController.errorMessage!),
                );
              }

              if (wishListController.wishListProduct.isEmpty) {
                return const Center(
                  child: Text('Empty wish list..!'),
                );
              }
              return GridView.builder(
                itemCount: wishListController.wishListProduct.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context,index){
                  final wishListProduct = wishListController.wishListProduct[index];
                  if (wishListProduct.product != null) {
                    return ProductCard(product: wishListProduct.product!);
                  } else {
                    return const Center(
                      child: Text('Invalid product data'),
                    );
                  }
                },
              );
            }
          ),
        ),
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }

}