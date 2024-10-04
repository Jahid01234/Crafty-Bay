import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key,});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(
      builder: (sliderListController) {
        return Visibility(
          visible: !sliderListController.inProgress,
          replacement: const SizedBox(
            height: 192,
            child: CenteredCircularProgressIndicator(),
          ),
          child: Column(
            children: [
              _buildCarouselSlider(sliderListController),
              const SizedBox(height: 8),
              _buildCarouselDots( sliderListController),
            ],
          ),
        );
      }
    );
  }

  Widget _buildCarouselSlider(SliderListController sliderListController) {
    return CarouselSlider(
              options: CarouselOptions(
                  height: 180,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    _selectedIndex.value = index;
                  },
              ),
              items: sliderListController.sliders.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration:  BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius:BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(slider.image.toString()),
                            fit: BoxFit.cover
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                           // Container(
                           //   height: 180,
                           //   width: 150,
                           //   decoration: BoxDecoration(
                           //     borderRadius: BorderRadius.only(
                           //       bottomLeft: Radius.circular(20),
                           //         topLeft: Radius.circular(20)
                           //     ),
                           //     image: DecorationImage(
                           //       image: NetworkImage(slider.image.toString()),
                           //       fit: BoxFit.cover
                           //     ),
                           //
                           //   ),
                           // ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    slider.price ?? '',
                                    textAlign: TextAlign.start,
                                    style:
                                    Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppColors.themeColor,
                                      ),
                                      onPressed: () {},
                                      child: const Text('Buy now'),
                                    ),
                                  )

                                ],
                              )
                          ),

                        ],
                      )
                    );
                  },
                );
              }).toList(),
            );
  }

  Widget _buildCarouselDots(SliderListController sliderListController) {
    return ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, currentIndex, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < sliderListController.sliders.length; i++)
                        Container(
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                              color: currentIndex == i
                                  ? AppColors.themeColor
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey,
                              ),
                          ),
                        ),
                    ],
                  );
                },
            );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}