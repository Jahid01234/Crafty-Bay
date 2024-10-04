import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends GetxController{

  bool _inProgress = false;
  List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(int categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
      await Get.find<NetworkCaller>().getRequest(
          url: Urls.productListByCategory(categoryId),
      );

    if(response.isSuccess){
      _productList = ProductListModel.fromJson(response.responseData).productList ?? [];
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