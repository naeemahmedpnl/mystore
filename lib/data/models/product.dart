
import '../../core/utils/app_logger.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    AppLogger.info('Parsing product: ${json['id']} - ${json['title']}');
    
    // Helper function to safely parse doubles
    double safeParseDouble(dynamic value, String fieldName) {
      if (value == null) {
        AppLogger.info('Product field "$fieldName" is null, defaulting to 0.0');
        return 0.0;
      }
      
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        final parsed = double.tryParse(value);
        if (parsed == null) {
          AppLogger.info('Could not parse "$value" as double for field "$fieldName", defaulting to 0.0');
        }
        return parsed ?? 0.0;
      }
      
      AppLogger.info('Unknown type ${value.runtimeType} for field "$fieldName", defaulting to 0.0');
      return 0.0;
    }
    
    // Helper function to safely parse integers
    int safeParseInt(dynamic value, String fieldName) {
      if (value == null) {
        AppLogger.info('Product field "$fieldName" is null, defaulting to 0');
        return 0;
      }
      
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed == null) {
          AppLogger.info('Could not parse "$value" as int for field "$fieldName", defaulting to 0');
        }
        return parsed ?? 0;
      }
      
      AppLogger.info('Unknown type ${value.runtimeType} for field "$fieldName", defaulting to 0');
      return 0;
    }
    

    List<String> safeParseStringList(dynamic value, String fieldName) {
      if (value == null) {
        AppLogger.info('Product field "$fieldName" is null, defaulting to empty list');
        return [];
      }
      
      if (value is List) {
        return value.map((item) => item?.toString() ?? '').toList();
      }
      
      AppLogger.info('Unknown type ${value.runtimeType} for field "$fieldName", defaulting to empty list');
      return [];
    }
    
    return Product(
      id: safeParseInt(json['id'], 'id'),
      title: json['title']?.toString() ?? 'Unknown Product',
      description: json['description']?.toString() ?? 'No description available',
      price: safeParseDouble(json['price'], 'price'),
      discountPercentage: safeParseDouble(json['discountPercentage'], 'discountPercentage'),
      rating: safeParseDouble(json['rating'], 'rating'),
      stock: safeParseInt(json['stock'], 'stock'),
      brand: json['brand']?.toString() ?? 'Unknown Brand',
      category: json['category']?.toString() ?? 'Uncategorized',
      thumbnail: json['thumbnail']?.toString() ?? '',
      images: safeParseStringList(json['images'], 'images'),
    );
  }
}
