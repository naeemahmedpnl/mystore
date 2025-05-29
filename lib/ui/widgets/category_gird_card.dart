import 'package:flutter/material.dart';
import 'package:my_store/ui/common/app_colors.dart';
import '../../data/models/category.dart';
import '../views/categories/products_by_category_screen.dart';

class CategoryGridCard extends StatelessWidget {
  final Category category;

  const CategoryGridCard({
    super.key,
    required this.category,
  });

  // This method returns a color based on the category slug
  Color getCategoryColor(String slug) {
    final int hash = slug.hashCode;
    final colorPair = colorPairs[hash.abs() % colorPairs.length];
    
    return colorPair[0]; 
  }

  @override
  Widget build(BuildContext context) {
    // Get a color for this category
    final Color categoryColor = getCategoryColor(category.slug);
    final Color categoryDarkColor = categoryColor.withAlpha(179); 

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsByCategoryScreen(category: category.slug),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              categoryColor,
              categoryDarkColor,
            ],
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Category icon
            Center(
              child: Icon(
                getCategoryIcon(category.slug),
                color: Colors.white.withAlpha(217), 
                size: 48,
              ),
            ),
            // Category name overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: Colors.black.withAlpha(102),
                child: Text(
                  category.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Return an appropriate icon for each category
  IconData getCategoryIcon(String slug) {
    switch (slug) {
      case 'beauty':
        return Icons.face;
      case 'fragrances':
        return Icons.spa;
      case 'furniture':
        return Icons.chair;
      case 'groceries':
        return Icons.shopping_basket;
      case 'home-decoration':
        return Icons.home;
      case 'kitchen-accessories':
        return Icons.kitchen;
      case 'laptops':
        return Icons.laptop;
      case 'mens-shirts':
        return Icons.checkroom;
      case 'mens-shoes':
        return Icons.accessibility;
      case 'mens-watches':
        return Icons.watch;
      case 'mobile-accessories':
        return Icons.headset;
      case 'motorcycle':
        return Icons.motorcycle;
      case 'skin-care':
        return Icons.face_retouching_natural;
      case 'smartphones':
        return Icons.smartphone;
      case 'sports-accessories':
        return Icons.sports_basketball;
      case 'sunglasses':
        return Icons.golf_course;
      case 'tablets':
        return Icons.tablet;
      case 'tops':
        return Icons.checkroom;
      case 'vehicle':
        return Icons.directions_car;
      case 'womens-bags':
        return Icons.shopping_bag;
      case 'womens-dresses':
        return Icons.checkroom;
      case 'womens-jewellery':
        return Icons.diamond;
      case 'womens-shoes':
        return Icons.accessibility;
      case 'womens-watches':
        return Icons.watch;
      default:
        return Icons.category;
    }
  }
}
