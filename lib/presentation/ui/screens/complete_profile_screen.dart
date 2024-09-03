import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              const AppLogoWidget(),
              const SizedBox(
                height: 24,
              ),
              Text(
                AppString.completeProfileText,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                AppString.getStartedText,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black45,
                ),
              ),
              const SizedBox(height: 16),

              // First name text form field
              TextFormField(
                controller: _firstNameTEController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText:AppString.firstNameHintText
                ),
              ),
              const SizedBox(height: 16),

              // Last name text form field
              TextFormField(
                controller: _lastNameTEController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText:AppString.lastNameHintText
                ),
              ),
              const SizedBox(height: 16),

              // Mobile text form field
              TextFormField(
                controller: _mobileTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText:AppString.mobileHintText
                ),
              ),
              const SizedBox(height: 16),

              // City text form field
              TextFormField(
                controller: _cityTEController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText:AppString.cityHintText
                ),
              ),
              const SizedBox(height: 16),

              // Shipping address text form field
              TextFormField(
                maxLines: 4,
                controller: _shippingTEController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText:AppString.shippingHintText
                ),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                  onPressed: _onTapCompleteButton,
                  child: const Text(
                    AppString.completeText,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapCompleteButton() {}

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingTEController.dispose();

    super.dispose();
  }

}
