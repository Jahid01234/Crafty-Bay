import 'package:crafty_bay/presentation/ui/utils/assets/app_assets.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                  AppAsset.appLogo,
                  width: 100,
              ),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text(
                AppString.splashScreenTitle,
                style: TextStyle(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
