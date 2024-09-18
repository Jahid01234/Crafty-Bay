import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _writeReviewTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Review"),
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(
              Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
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

              // write Review text form field
              TextFormField(
                maxLines: 10,
                controller: _writeReviewTEController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText:"Write review"
                ),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _onTapCompleteButton,
                child: const Text(
                  "Submit",
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
    _writeReviewTEController.dispose();

    super.dispose();
  }

}
