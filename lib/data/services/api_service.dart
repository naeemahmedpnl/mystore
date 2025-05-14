import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/app_logger.dart';

class ApiService {
  final http.Client client = http.Client();

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    // Log the request URL
    AppLogger.info('API Request: GET $url');

    try {
      final response = await client.get(url);

      // Log the response status code
      AppLogger.info('API Response Status: ${response.statusCode}');

      return _processResponse(response);
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
