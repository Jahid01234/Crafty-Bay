import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  final int productId;

  const ReviewsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

   @override
  void initState() {
    super.initState();
    Get.find<ReviewListController>().getReviewListById(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15
              ),
              child:GetBuilder<ReviewListController>(
                builder: (reviewListController) {
                  if (reviewListController.inProgress) {
                    return const CenteredCircularProgressIndicator();
                  }
                  if (reviewListController.reviewList.isEmpty) {
                    return const Center(child: Text('No reviews available.'));
                  }

                  return ListView.builder(
                      itemCount: reviewListController.reviewList.length ,
                      itemBuilder: (context, index){
                        return  Card(
                          color: Colors.white,
                          elevation: 0.5,
                          child:  ListTile(
                                title:  Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.person_outline_outlined,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8,),
                                    Text(
                                        reviewListController.reviewList[index].profile!.cusName ?? '',
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  reviewListController.reviewList[index].description ?? '',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                        );
                      },
                  );
                }
              ) ,
            ),
          ),
          _buildReviewsAndAddToReviewSection(),
        ],
      ),
    );
  }

  Container _buildReviewsAndAddToReviewSection() {
    return Container(
          decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GetBuilder<ReviewListController>(
              builder: (reviewListController) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reviews (${reviewListController.reviewList.length})",
                        style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                            ),
                        ),
                        onPressed: () {
                          Get.to(()=>  CreateReviewScreen(
                            productId: widget.productId,
                           ),
                          );
                        },
                        child: const Icon(Icons.add,size: 17,),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        );
  }

}
