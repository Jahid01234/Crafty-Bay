import 'package:crafty_bay/presentation/ui/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.appLogo,
      width: 100,
    );
  }
}