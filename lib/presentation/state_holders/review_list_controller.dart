import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController{

  bool _inProgress = false;
  List<ReviewModel> _reviewList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<ReviewModel> get reviewList => _reviewList;
  String? get errorMessage => _errorMessage;

  Future<bool> getReviewListById(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(
      url: Urls.reviewByProduct(productId),
    );

    if(response.isSuccess){
      _reviewList = ReviewListModel.fromJson(response.responseData).reviewList ?? [];
      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }


    _inProgress = false;
    update();
    return isSuccess;
  }


}