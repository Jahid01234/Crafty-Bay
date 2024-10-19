import 'package:crafty_bay/presentation/state_holders/create_product_review_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  final int productId;
  const CreateReviewScreen({super.key, required this.productId});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _writeReviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   double _rating = 3;

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                // First name text form field
                TextFormField(
                  controller: _firstNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText:AppString.firstNameHintText
                  ),
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your first name";
                    }
                    return null;
                  } ,
                ),
                const SizedBox(height: 16),

                // Last name text form field
                TextFormField(
                  controller: _lastNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText:AppString.lastNameHintText
                  ),
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your last name";
                    }
                    return null;
                  } ,
                ),
                const SizedBox(height: 16),

                // write Review text form field
                TextFormField(
                  maxLines: 10,
                  controller: _writeReviewTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText:"Write review"
                  ),
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write review";
                    }
                    return null;
                  } ,
                ),
                const SizedBox(height: 16),
                // Give Review part
                const Text("Give Rating"),
                RatingBar.builder(
                  direction: Axis.horizontal,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  allowHalfRating: true,
                  itemSize: 25,
                  initialRating: _rating,
                  minRating: 1,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.themeColor,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                GetBuilder<CreateProductReviewController>(
                  builder: (createProductReviewController) {
                    return Visibility(
                      visible: !createProductReviewController.inProgress,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapCompleteButton,
                        child: const Text(
                          "Submit",
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

  void _onTapCompleteButton() async{
    if(_formKey.currentState!.validate()){
     final result = await Get.find<CreateProductReviewController>().
     createReview(
        _writeReviewTEController.text,
        widget.productId,
        _rating.toInt(),
     );
     if(result){
       if(mounted) {
         showSnackBarMessage(context, "Added to review successfully!");
       }
     }else{
       if(mounted) {
         showSnackBarMessage(context, Get.find<CreateProductReviewController>().errorMessage!,true);
       }
     }
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _writeReviewTEController.dispose();

    super.dispose();
  }

}
