import 'package:crafty_bay/data/models/wish_list_product_model.dart';

class WishListModel {
  String? msg;
  List<WishListProductModel>? products;

  WishListModel({
    this.msg,
    this.products,
  });

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      products = <WishListProductModel>[];
      json['data'].forEach((v) {
        products!.add(new WishListProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.products != null) {
      data['data'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


