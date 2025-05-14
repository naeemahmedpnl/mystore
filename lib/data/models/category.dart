
import '../../core/utils/app_logger.dart';

class Category {
  final String slug;
  final String name;
  final String url;

  Category({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    AppLogger.info('Parsing category: ${json['name']}');
    
    return Category(
      slug: json['slug']?.toString() ?? 'unknown',
      name: json['name']?.toString() ?? 'Unknown Category',
      url: json['url']?.toString() ?? '',
    );
  }
}