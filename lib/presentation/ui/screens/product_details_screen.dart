import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/color_picker.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_image_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Column(
        children: [
           const ProductImageSlider(),
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Expanded(
                       child: Text('Nike shoe 2024 latest model - New year special deal',
                         style: Theme.of(context).textTheme.titleMedium,
                       ),
                     ),
                     ItemCount(
                         color: AppColors.themeColor.withOpacity(0.4),
                         initialValue: 1,
                         minValue: 1,
                         maxValue: 20,
                         decimalPlaces: 0,
                         onChanged: (value){
                           setState(() {});
                         },
                     ),
                   ],
                 ),
                 const SizedBox(height: 4),
                 Wrap(
                   crossAxisAlignment: WrapCrossAlignment.center,
                   children: [
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
                     const SizedBox(width: 8),
                     TextButton(
                       onPressed: (){},
                       child: const Text(
                         "Reviews",
                         style: TextStyle(
                           fontWeight: FontWeight.w500,
                           color:AppColors.themeColor,
                         ),
                       ),
                     ),
                     const SizedBox(width: 8),
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
                 const SizedBox(height: 8),
                 ColorPicker(
                     colors: const [
                       Colors.blue,
                       Colors.greenAccent,
                       Colors.teal,
                       Colors.cyan
                     ],
                     onColorSelected: (color){},
                 ),
               ],
             ),
           ),


        ],
      ),
    );
  }
}
