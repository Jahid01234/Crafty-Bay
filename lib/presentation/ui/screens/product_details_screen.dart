import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/color_picker.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';


class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedColor = '';
  String _selectedSize = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if (productDetailsController.inProgress) {
            return const CenteredCircularProgressIndicator();
          }

          if (productDetailsController.errorMessage != null) {
            return Center(
              child: Text(productDetailsController.errorMessage!),
            );
          }

          return Column(
            children: [
              Expanded(
                child: _buildProductDetails(productDetailsController.product!),
              ),
              _buildPriceAndAddToCartSection(productDetailsController.product!),
            ],
          );
        }
      ),
    );
  }

  Widget _buildProductDetails(ProductDetailsModel product) {
    List<String> colors = product.color!.split(',');
    List<String> sizes = product.size!.split(',');
    _selectedColor = colors.first;
    _selectedSize = sizes.first;

    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              product.img1!,
              product.img2!,
              product.img3!,
              product.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(product),
                const SizedBox(height: 4),
                _buildRatingAndReviewSection(product),
                const SizedBox(height: 8),
                ColorPicker(
                    //colors: product.color!.split(','),
                    colors: colors,
                    onColorSelected: (String selectedColor){
                      _selectedColor = selectedColor;
                    }
                ),

                const SizedBox(height: 15),
                SizePicker(
                  //sizes: product.size!.split(','),
                  sizes: sizes,
                  onSizeSelected: (String selectedSize) {
                    _selectedSize = selectedSize;
                  },
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(product),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(ProductDetailsModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
         Text(
          product.des.toString(),
          textAlign: TextAlign.justify,
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel product) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.product!.title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ItemCount(
          color: AppColors.themeColor.withOpacity(0.4),
          initialValue: quantity,
          minValue: 1,
          maxValue: 20,
          decimalPlaces: 0,
          onChanged: (value) {
            quantity = value.toInt();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildRatingAndReviewSection(ProductDetailsModel product) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
         Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text(
              product.product!.star.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            Get.to(()=>  ReviewsScreen(
              productId: widget.productId,

             ),
            );
          },
          child: const Text(
            "Reviews",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Card(
          elevation: 0,
          color: AppColors.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.favorite_border_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel product) {
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
              const Text("Price"),
              Text(
                "\$${product.product!.price}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                return Visibility(
                  visible: !addToCartController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapAddToCart,
                    child: const Text("Add To Cart"),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _onTapAddToCart() async {
    bool isLoggedInUser =  Get.find<AuthController>().isLoggedInUser();
    if(isLoggedInUser){
       AuthController.accessToken;
       final result = await Get.find<AddToCartController>().addToCart(
           widget.productId,
           _selectedColor,
           _selectedSize,
           quantity
       );

       if(result){
         if(mounted) {
           showSnackBarMessage(context, "Added to cart successfully!");
         }
       }else{
         if(mounted) {
           showSnackBarMessage(context, Get.find<AddToCartController>().errorMessage!,true);
         }
       }
    } else{
      Get.to(()=> const EmailVerificationScreen());
    }

  }
}
