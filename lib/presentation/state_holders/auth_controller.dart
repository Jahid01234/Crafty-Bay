import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  static String? accessToken;
  final String _accessTokenKey = 'access-token';

  // set access token
  Future<void> saveAccessToken (String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  // get access token
  Future<String?> getAccessToken () async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token =  sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  // check user login or not
  bool isLoggedInUser() {
    return accessToken != null;
  }

  // delete user all data
  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

}