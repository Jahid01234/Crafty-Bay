import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/models/wish_list_product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';


class WishListController extends GetxController {
  bool _inProgress = false;
  List<WishListProductModel> _wishListProduct = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<WishListProductModel> get wishListProduct => _wishListProduct;
  String? get errorMessage => _errorMessage;


  Future<bool> getWishList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.fetchWishList,
    );

    if (response.isSuccess) {
      _wishListProduct = WishListModel.fromJson(response.responseData).products ?? [];
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}