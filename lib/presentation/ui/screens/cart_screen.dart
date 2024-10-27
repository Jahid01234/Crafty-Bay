import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child:ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index){
                  return const CartItemWidget();
                }
              ) ,
            ),

            // Bottom section(Total price and checkOut button)
            _buildPriceAndAddToCartSection(),
          ],
        )
      ),
    );
  }


  Widget _buildPriceAndAddToCartSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Price"),
              Text(
                "\$1,000",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: _onTapCheckOutButton,
              child: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapCheckOutButton(){
    Get.to(()=> const PaymentDetailsScreen());
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
