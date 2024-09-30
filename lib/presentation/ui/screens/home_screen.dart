import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/assets/app_assets.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/app_bar_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/home_banner_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/horizontal_category_list_view.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/horizontal_product_list_view.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/search_box_text_field.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [

              const SizedBox(height: 16),
              SearchBoxTextField(
                 textEditingController: TextEditingController(),
               ),
              const SizedBox(height: 16),
              const HomeBannerSlider(),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              const SizedBox(height: 4),
              _buildPopularProductSection(),
              const SizedBox(height: 16),
              _buildSpecialProductSection(),
              const SizedBox(height: 16),
              _buildNewProductSection(),
              const SizedBox(height: 40),
              
            ],
          ),
        ),
      ) ,
    );
  }

  Widget _buildPopularProductSection(){
    return Column(
      children: [
        SectionHeader(
          title: "Popular",
          onTap: (){},
        ),
        const SizedBox(height: 4),
        const SizedBox(
          height: 180,
          child: HorizontalProductListView(),
        ),
      ],
    );
  }

  Widget _buildSpecialProductSection(){
    return Column(
      children: [
        SectionHeader(
          title: "Special",
          onTap: (){},
        ),
        const SizedBox(height: 4),
        const SizedBox(
          height: 180,
          child: HorizontalProductListView(),
        ),
      ],
    );
  }

  Widget _buildNewProductSection(){
    return Column(
      children: [
        SectionHeader(
          title: "New",
          onTap: (){},
        ),
        const SizedBox(height: 4),
        const SizedBox(
          height: 180,
          child: HorizontalProductListView(),
        ),
      ],
    );
  }


  Widget _buildCategoriesSection() {
    return Column(
            children: [
              SectionHeader(
                  title: AppString.categoriesText,
                  onTap: (){
                    Get.find<BottomNavBarController>().selectCategory();
                  },
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 120,
                child: GetBuilder<CategoryListController>(
                  builder: (categoryListController) {
                    return Visibility(
                      visible: !categoryListController.inProgress,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: HorizontalCategoryListView(
                          categoryList: categoryListController.categoryList,
                        ),
                    );
                  }
                ),
              ),
            ],
          );
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      title: SvgPicture.asset(AssetsPath.appLogoNav),
      actions: [
        AppBarIconButton(
          onTap: () { },
          iconData: Icons.perm_identity_outlined,
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          onTap: () { },
          iconData: Icons.call_outlined,
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
        onTap: () { },
        iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}










