import 'package:crafty_bay/presentation/ui/utils/assets/app_assets.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_bar_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/home_banner_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/search_box_text_field.dart';
import 'package:crafty_bay/presentation/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body:Padding(
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
          ],
        ),
      ) ,
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
            children: [
              SectionHeader(
                  title: "All Categories",
                  onTap: (){},
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: _buildCategoryListView(),
              ),
            ],
          );
  }

  Widget _buildCategoryListView() {
    return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (_,__){
                    return const SizedBox(width: 8);
                  },
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration:  BoxDecoration(
                            color: AppColors.themeColor.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:const  Icon(
                            Icons.computer,
                            size: 48,
                            color: AppColors.themeColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Electronics',
                          style: TextStyle(
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    );
                  },
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




