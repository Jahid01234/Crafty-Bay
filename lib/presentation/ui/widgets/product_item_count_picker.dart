import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProductItemCountPicker extends StatelessWidget {
  final int itemBuyingAmount;
  final VoidCallback plusButtonOnPressed;
  final VoidCallback minusButtonOnPressed;

  const ProductItemCountPicker({
    super.key,
    required this.itemBuyingAmount,
    required this.plusButtonOnPressed,
    required this.minusButtonOnPressed,
  });



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // 1st: decrement icon....
        IconButton(
          onPressed: minusButtonOnPressed,
          iconSize: 18,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
          icon: const Icon(
            Icons.horizontal_rule,
            color: Colors.white,
          ),
          style: IconButton.styleFrom(
              backgroundColor: AppColors.themeColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.5),
              ),
          ),
        ),

        // 2nd: show count number........
        Text(
            itemBuyingAmount.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
            ),
        ),

        // 3rd: increment icon....
        IconButton(
          onPressed: plusButtonOnPressed,
          iconSize: 18,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: IconButton.styleFrom(
              backgroundColor: AppColors.themeColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.5),
              ),
          ),
        ),
      ],
    );
  }
}