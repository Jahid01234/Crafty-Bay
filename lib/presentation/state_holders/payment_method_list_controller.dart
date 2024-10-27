import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/payment_method_list_model.dart';
import 'package:crafty_bay/data/models/payment_method_response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class PaymentMethodListController extends GetxController{
  bool _inProgress = false;
  PaymentMethodResponseData? _paymentMethodResponseData;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  PaymentMethodResponseData? get paymentMethodResponseData => _paymentMethodResponseData;
  String? get errorMessage => _errorMessage;

  Future<bool> getPaymentMethodList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.createInvoice,
    );

    if (response.isSuccess) {
      _paymentMethodResponseData = PaymentMethodListModel.fromJson(response.responseData).data?.first;
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