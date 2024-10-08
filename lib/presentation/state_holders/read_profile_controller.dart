import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController{
  bool _inProgress = false;
  bool _isProfileCompleted = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  bool get isProfileCompleted => _isProfileCompleted;
  String? get errorMessage => _errorMessage;

  Future<bool> getProfileDetails(String token) async{
     bool isSuccess = false;
     _inProgress = true;
     update();

     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
         url: Urls.readProfile,
          token: token
     );

     if(response.isSuccess){
       if(response.responseData['data'] != null){
         _isProfileCompleted = true;
       }
       _errorMessage = null;
       isSuccess = true;

     } else{
       _errorMessage = response.errorMessage;
     }

     _inProgress = false;
     update();
     return isSuccess;
  }

}