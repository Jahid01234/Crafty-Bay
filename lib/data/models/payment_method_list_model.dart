import 'package:crafty_bay/data/models/payment_method_response_data.dart';

class PaymentMethodListModel {
  String? msg;
  List<PaymentMethodResponseData>? data;

  PaymentMethodListModel({
    this.msg,
    this.data,
  });

  PaymentMethodListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PaymentMethodResponseData>[];
      json['data'].forEach((v) {
        data!.add(PaymentMethodResponseData.fromJson(v));
      });
    }
  }
}