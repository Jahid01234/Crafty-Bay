import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
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
              child:ListView.builder(
                  itemCount: 20 ,
                  itemBuilder: (context, index){
                    return  Card(
                      color: Colors.white,
                      elevation: 0.5,
                      child: ListTile(
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
                            const Text("Jahid Hasan"),
                          ],
                        ),
                        subtitle: const Text(
                          "Nike is the most popular sneaker brand in the "
                              "United States, followed by Adidas and New Balance. To no"
                              " one's surprise Nike is the leading sneaker brand in all "
                              "our measured brand KPIs. It is rivaled only by Adidas in "
                              "brand awareness, while New Balance and Skechers jointly rank"
                              " third in brand ownership share",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Reviews (1000)",
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
                      Get.to(()=> const CreateReviewScreen());
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        );
  }

}
