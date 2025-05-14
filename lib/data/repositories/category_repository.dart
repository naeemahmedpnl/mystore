import '../models/category.dart';
import '../services/api_service.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/app_logger.dart';

class CategoryRepository {
  final ApiService _apiService = ApiService();

  Future<List<Category>> getAllCategories() async {
    AppLogger.info('Repository: Fetching all categories');

    try {
      final response = await _apiService.get(ApiConstants.categoriesEndpoint);

      AppLogger.info('Repository: Successfully fetched categories data');

      // Create a list to store any parsing errors
      List<String> parsingErrors = [];

      // Parse categories with error handling
      final List<dynamic> categoriesData = response;
      final result = categoriesData.map((categoryJson) {
        try {
          return Category.fromJson(categoryJson);
        } catch (e) {
          parsingErrors.add('Error parsing category: $e, JSON: $categoryJson');
          // Return a placeholder category if parsing fails
          return Category(
            slug: 'unknown',
            name: 'Error loading category',
            url: '',
          );
        }
      }).toList();

      // Log any parsing errors
      if (parsingErrors.isNotEmpty) {
        AppLogger.error('Category parsing errors:');
        for (var error in parsingErrors) {
          AppLogger.error(error);
        }
      }

      return result;
    } catch (e) {
      AppLogger.error('Repository: Error fetching categories: $e');
      rethrow;
    }
  }
}
