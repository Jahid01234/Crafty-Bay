import 'dart:convert';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller{
    final Logger logger;
    final AuthController authController;

    NetworkCaller({required this.logger, required this.authController});

    // Get api method
    Future<NetworkResponse> getRequest({required String url, String? token}) async{

        try {
            // Use logger section to see the output console
            _requestLog(url, {}, {}, '');

            final Response response = await get(
                Uri.parse(url),
                headers: {
                    'token': '${token ?? AuthController.accessToken}'
                }
            );

            if (response.statusCode == 200) {
                // Use logger section to see the output console
                _responseLog(url, response.statusCode, response.body, response.headers, true);

                final decodedBody = jsonDecode(response.body);
                return NetworkResponse(
                    statusCode: response.statusCode,
                    isSuccess: true,
                    responseData: decodedBody
                );
            } else {
                // Use logger section to see the output console
                _responseLog(url, response.statusCode, response.body, response.headers, false);
                if(response.statusCode == 401){
                    _moveToLogin();
                }
                return NetworkResponse(
                    statusCode: response.statusCode,
                    isSuccess: false,
                );
            }
        }catch (e) {
            // Use logger section to see the output console
            _responseLog(url, -1, null, {}, false, e);

            return NetworkResponse(
                statusCode: -1,
                isSuccess: false,
                errorMessage: e.toString()
            );
        }

    }

    // Post api method
    Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body }) async{

        try {
            // Use logger section to see the output console
            _requestLog(url, {}, body ?? {}, AuthController.accessToken ?? '');

            final Response response = await post(
                Uri.parse(url),
                body: jsonEncode(body),
                headers: {
                    'Content-type': 'Application/json',
                    'token': '${AuthController.accessToken}'
                }
            );

            if (response.statusCode == 200) {
                // Use logger section to see the output console
                _responseLog(url, response.statusCode, response.body, response.headers, true);

                final decodedBody = jsonDecode(response.body);
                return NetworkResponse(
                    statusCode: response.statusCode,
                    isSuccess: true,
                    responseData: decodedBody
                );
            } else {
                // Use logger section to see the output console
                _responseLog(url, response.statusCode, response.body, response.headers, false);
                if(response.statusCode == 401){
                    _moveToLogin();
                }

                return NetworkResponse(
                    statusCode: response.statusCode,
                    isSuccess: false,
                );
            }
        }catch (e) {
            // Use logger section to see the output console
            _responseLog(url, -1, null, {}, false, e);

            return NetworkResponse(
                statusCode: -1,
                isSuccess: false,
                errorMessage: e.toString()
            );
        }

    }



    // When unauthorized , it clear all data and again login
    Future<void> _moveToLogin() async {
        await authController.clearUserData();
        getx.Get.to(() => const EmailVerificationScreen());
    }

    // logger section to see the output console
    // request Log--
    void _requestLog(
        String url,
        Map<String, dynamic> params,
        Map<String, dynamic> body,
        String token,
        ) {
        logger.i('''
              Url: $url,
              Params: $params,
              Body: $body,
              Token: $token
              ''');
    }

    // response Log--
    void _responseLog(
        String url,
        int statusCode,
        dynamic responseBody,
        Map<String, dynamic> headers,
        bool isSuccess,
        [dynamic error]
        ) {
        String message = '''
             Url: $url,
             Status Code: $statusCode,
             Headers: $headers,
             Response Body: $responseBody,
             Error: $error,
            ''';
        if (isSuccess) {
            logger.i(message);
        } else {
            logger.e(message);
        }
    }



}