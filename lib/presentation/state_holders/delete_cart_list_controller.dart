import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';


class DeleteCartListController extends GetxController{
  final Map<int, bool> _loadingMap = {};
  bool isLoading(int productId) => _loadingMap[productId] ?? false;

  String? _errorMessage ;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteCartList(int productId) async{
    bool isSuccess = false;
    _loadingMap[productId] = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.deleteCartList(productId),
    );

    if(response.isSuccess && response.responseData['msg'] == 'success'){
      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _loadingMap.remove(productId);
    update();
    return isSuccess;
  }

}