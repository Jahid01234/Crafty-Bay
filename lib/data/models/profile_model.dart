
class ProfileModel {
  int? id;
  String? cusName;

  ProfileModel({
    this.id,
    this.cusName,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cus_name'] = this.cusName;
    return data;
  }
}