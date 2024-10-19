import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/ui/utils/assets/app_assets.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> sliderUrls;

  const ProductImageSlider({
    super.key,
    required this.sliderUrls,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                _selectedIndex.value = index;
              },
            ),
            items: widget.sliderUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      image:  DecorationImage(
                          image: NetworkImage(
                              imageUrl,
                          ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, currentIndex, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.sliderUrls.length; i++)
                      Container(
                        height: 12,
                        width: 12,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: currentIndex == i
                              ? AppColors.themeColor
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}