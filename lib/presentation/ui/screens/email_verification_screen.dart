import 'package:crafty_bay/presentation/state_holders/email_verification_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final EmailVerificationController _emailVerificationController = Get.find<EmailVerificationController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  AppString.welcomeBack,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  AppString.emailAddress,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black45),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText:AppString.emailHintText
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<EmailVerificationController>(
                  builder: (emailVerificationController) {
                    return Visibility(
                      visible: !emailVerificationController.inProgress,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Next Button
  void _onTapNextButton() async{
    if (_formKey.currentState!.validate()) {

      bool result = await _emailVerificationController.verifyEmail(_emailTEController.text.trim());
      if(result) {
        Get.to(() =>  OtpVerificationScreen(email: _emailTEController.text,));
      } else{
          if(mounted){
            showSnackBarMessage(context, _emailVerificationController.errorMessage!, true);
          }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

}
