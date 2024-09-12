import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/assets/app_assets.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> const ProductDetailsScreen());
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 130,
                padding: const EdgeInsets.all(16),
                decoration:  BoxDecoration(
                    color: AppColors.themeColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    ),
                    image: const DecorationImage(
                        image: AssetImage(
                          AssetsPath.dummyProductImg,
                        ),
                      fit: BoxFit.scaleDown
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Product Name ",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "\$120 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:AppColors.themeColor,
                          ),
                        ),
                        const Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Text(
                              "3.4 ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        Card(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}