
import '../models/product.dart';
import '../services/api_service.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/app_logger.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();

  Future<List<Product>> getAllProducts() async {
    AppLogger.info('Repository: Fetching all products');
    
    try {
      final response = await _apiService.get(ApiConstants.productsEndpoint);
      final products = response['products'] as List;
      
      AppLogger.info('Repository: Fetched ${products.length} products');
      
      // Create a list to store any parsing errors
      List<String> parsingErrors = [];
      
      // Parse products with error handling
      final result = products.map((productJson) {
        try {
          return Product.fromJson(productJson);
        } catch (e) {
          parsingErrors.add('Error parsing product: $e, JSON: $productJson');
          return Product(
            id: 0,
            title: 'Error loading product',
            description: 'There was an error loading this product',
            price: 0,
            discountPercentage: 0,
            rating: 0,
            stock: 0,
            brand: 'Unknown',
            category: 'Unknown',
            thumbnail: '',
            images: [],
          );
        }
      }).toList();
      
      // Log any parsing errors
      if (parsingErrors.isNotEmpty) {
        AppLogger.error('Product parsing errors:');
        for (var error in parsingErrors) {
          AppLogger.error(error);
        }
      }
      
      return result;
    } catch (e) {
      AppLogger.error('Repository: Error fetching products: $e');
      rethrow;
    }
  }

  Future<Product> getProductById(int id) async {
    AppLogger.info('Repository: Fetching product with id: $id');
    
    try {
      final response = await _apiService.get('${ApiConstants.singleProductEndpoint}/$id');
      
      AppLogger.info('Repository: Successfully fetched product with id: $id');
      
      return Product.fromJson(response);
    } catch (e) {
      AppLogger.error('Repository: Error fetching product with id $id: $e');
      rethrow;
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    AppLogger.info('Repository: Fetching products for category: $category');
    
    try {
      final response = await _apiService.get('${ApiConstants.productsByCategoryEndpoint}/$category');
      final products = response['products'] as List;
      
      AppLogger.info('Repository: Fetched ${products.length} products for category: $category');
      
      // Create a list to store any parsing errors
      List<String> parsingErrors = [];
      
      // Parse products with error handling
      final result = products.map((productJson) {
        try {
          return Product.fromJson(productJson);
        } catch (e) {
          parsingErrors.add('Error parsing product: $e, JSON: $productJson');
          // Return a placeholder product if parsing fails
          return Product(
            id: 0,
            title: 'Error loading product',
            description: 'There was an error loading this product',
            price: 0,
            discountPercentage: 0,
            rating: 0,
            stock: 0,
            brand: 'Unknown',
            category: 'Unknown',
            thumbnail: '',
            images: [],
          );
        }
      }).toList();
      
      // Log any parsing errors
      if (parsingErrors.isNotEmpty) {
        AppLogger.error('Product parsing errors:');
        for (var error in parsingErrors) {
          AppLogger.error(error);
        }
      }
      
      return result;
    } catch (e) {
      AppLogger.error('Repository: Error fetching products for category $category: $e');
      rethrow;
    }
  }
}
