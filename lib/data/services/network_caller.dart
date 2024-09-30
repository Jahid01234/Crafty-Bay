import 'dart:convert';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller{
    final Logger logger;
    NetworkCaller({required this.logger});

    // Get api method
    Future<NetworkResponse> getRequest({required String url}) async{

        try {
            // Use logger section to see the output console
            _requestLog(url, {}, {}, '');

            final Response response = await get(
                Uri.parse(url),
                headers: {
                    'token': ''
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
            _requestLog(url, {}, body ?? {}, '');

            final Response response = await post(
                Uri.parse(url),
                body: jsonEncode(body),
                headers: {
                    'Content-type': 'Application/json',
                    'token': ''
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


    // logger section to see the output console
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