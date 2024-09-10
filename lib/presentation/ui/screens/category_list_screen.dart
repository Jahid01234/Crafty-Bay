import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        backToHome();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Categories"),
            leading: IconButton(
              onPressed: backToHome,
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7
                ),
                itemBuilder: (context, index){
                  return const CategoryCard();
                },
            ),
          ) ,
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }

}
