import 'package:crafty_bay/presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpVerificationController _otpVerificationController = Get.find<OtpVerificationController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 82,
                ),
                const AppLogoWidget(),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  AppString.enterOtpText,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  AppString.otpDescriptionText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black45,
                      ),
                ),
                const SizedBox(height: 16),
                PinCodeTextField(
                  length: 6,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: AppColors.themeColor,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColors.themeColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _otpTEController,
                  appContext: context,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a PIN code';
                      }
                      if (value.length != 6) {
                        return 'PIN code must be 6 digits';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'PIN code must contain only digits';
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 16),
                GetBuilder<OtpVerificationController>(
                  builder: (otpVerificationController) {
                    return Visibility(
                      visible: !otpVerificationController.inProgress,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: _onTapNextButton,
                          child: const Text(
                              AppString.nextText,
                          ),
                      ),
                    );
                  }
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                    text: AppString.expireText,
                    children: const [
                      TextSpan(
                        text: AppString.one20Text,
                        style: TextStyle(color: AppColors.themeColor),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: (){},
                    child: const Text(
                        AppString.resendText,
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() async{
    if(_formKey.currentState!.validate()){
      bool result =  await _otpVerificationController.verifyOtp(widget.email, _otpTEController.text);
      if(result){
        Get.to(() => const CompleteProfileScreen());
      }else{
        if (mounted) {
          showSnackBarMessage(context, _otpVerificationController.errorMessage!,true);
        }
      }
    }

  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
