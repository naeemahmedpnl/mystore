import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_store/core/errors/exceptions.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/app_logger.dart';

class ApiService {
  final http.Client client = http.Client();

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    // Log the request URL
    AppLogger.info('API Request: GET $url');

    try {
      final response = await client.get(url, headers: {
        'Content-Type': 'application/json',
      }).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw const SocketException('Connection timed out');
        },
      );

      // Log the response status code
      AppLogger.info('API Response Status: ${response.statusCode}');

      return _processResponse(response);
    } on SocketException catch (e) {
      // Handle network errors specifically
      AppLogger.error('Network Error: ${e.message}');
      throw ApiException(
        message: 'No internet connection. Please check your network settings.',
        statusCode: null,
      );
    } catch (e) {
      // Log any errors during request
      AppLogger.error('API Request Error: $e');
      throw ApiException(message: e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        // Log the response body (limited to prevent console flooding)
        final previewLength =
            response.body.length > 500 ? 500 : response.body.length;
        AppLogger.info(
            'API Response Body Preview: ${response.body.substring(0, previewLength)}${response.body.length > 500 ? "..." : ""}');

        return json.decode(response.body);
      } catch (e) {
        AppLogger.error('Raw Response: ${response.body}');
        throw ApiException(
            message: 'Failed to parse response: ${e.toString()}');
      }
    } else {
      throw ApiException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}
