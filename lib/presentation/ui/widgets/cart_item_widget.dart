import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_count_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartItemWidget extends StatefulWidget {
  final CartModel cartItem;

  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0.5,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          // Image section
          _buildProductImage(widget.cartItem.product!.image),

          // Other section
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cartItem.product!.title ?? 'Unknown Product',
                            style: textTheme.bodyLarge,
                          ),
                          _buildColorAndSize(widget.cartItem.color, widget.cartItem.size, textTheme),
                        ],
                      ),
                    ),
                     GetBuilder<DeleteCartListController>(
                       builder: (deleteCartListController) {
                         bool isLoading = deleteCartListController.isLoading(widget.cartItem.id!);

                         return isLoading
                             ? const CenteredCircularProgressIndicator()
                             : IconButton(
                                  onPressed: () async{
                                    final cartController = Get.find<CartListController>();

                                    bool isDeleted = await deleteCartListController.deleteCartList(widget.cartItem.id!);

                                    if (isDeleted) {
                                      cartController.updateTotalPriceAfterDeletion(
                                        int.parse(widget.cartItem.price ?? '0'),
                                      );
                                      cartController.cartModel.remove(widget.cartItem);
                                      cartController.update();
                                    }else{
                                      showSnackBarMessage(context, "Product does not deleted!");
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.cyan,
                                  ),
                                );
                           },
                     ),
                  ],
                ),

                // Price and counter button Row section
                _buildPriceAndCounter(widget.cartItem.price, widget.cartItem.qty, textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndCounter(String? price, String? quantityStr, TextTheme textTheme) {
    // Convert quantity from String? to int
    int quantity = int.tryParse(quantityStr ?? '1') ?? 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$$price",
          style: textTheme.titleMedium?.copyWith(
              color: AppColors.themeColor,
          ),
        ),
        ProductItemCountPicker(
          itemBuyingAmount: quantity,
          plusButtonOnPressed: (){
            quantity++;
            setState(() {});
          },
          minusButtonOnPressed: (){
            if(quantity>1){
              quantity--;
              setState(() {});
            }
          },
        ),

      ],
    );
  }

  Widget _buildColorAndSize(String? color, String? size, TextTheme textTheme) {
    return Wrap(
      spacing: 8,
      children: [
        Text(
          'Color: $color',
          style: textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
        Text(
          'Size: $size',
          style: textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        imageUrl ?? '',
        height: 80,
        width: 80,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
