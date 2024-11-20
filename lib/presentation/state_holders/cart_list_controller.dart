import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';


class CartListController extends GetxController {
  bool _inProgress = false;
  List<CartModel> _cartModel = [];
  String? _errorMessage;
  int _totalPrice = 0;


  bool get inProgress => _inProgress;
  List<CartModel> get cartModel => _cartModel;
  String? get errorMessage => _errorMessage;
  int get totalPrice => _totalPrice;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.fetchCarts,
    );

    if (response.isSuccess) {
      _cartModel = CartListModel.fromJson(response.responseData).data ?? [];

      _totalPrice = 0;
      for (CartModel cart in _cartModel) {
        _totalPrice += int.parse(cart.price ?? '0');
      }
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