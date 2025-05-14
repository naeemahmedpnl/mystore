// // lib/ui/widgets/category_grid_card.dart
// import 'package:flutter/material.dart';
// import '../../data/models/category.dart';
// import '../views/categories/products_by_category_screen.dart';

// class CategoryGridCard extends StatelessWidget {
//   final Category category;

//   const CategoryGridCard({
//     super.key,
//     required this.category,
//   });


//     // This method returns a predefined image URL based on category slug
//   String getCategoryImage(String slug) {
//     // Map of category slugs to relevant images
//     final Map<String, String> categoryImages = {
//       'beauty': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=800&auto=format&fit=crop',
//       'fragrances': 'https://images.unsplash.com/photo-1557517915-74d86b523e35?w=800&auto=format&fit=crop',
//       'furniture': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop',
//       'groceries': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800&auto=format&fit=crop',
//       'home-decoration': 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?w=800&auto=format&fit=crop',
//       'kitchen-accessories': 'https://images.unsplash.com/photo-1556910638-b02c806099dd?w=800&auto=format&fit=crop',
//       'laptops': 'https://images.unsplash.com/photo-1611078489935-0cb964de46d6?w=800&auto=format&fit=crop',
//       'mens-shirts': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=800&auto=format&fit=crop',
//       'mens-shoes': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&auto=format&fit=crop',
//       'mens-watches': 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800&auto=format&fit=crop',
//       'mobile-accessories': 'https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?w=800&auto=format&fit=crop',
//       'motorcycle': 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=800&auto=format&fit=crop',
//       'skin-care': 'https://images.unsplash.com/photo-1571875257727-256c39da42af?w=800&auto=format&fit=crop',
//       'smartphones': 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=800&auto=format&fit=crop',
//       'sports-accessories': 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=800&auto=format&fit=crop',
//       'sunglasses': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&auto=format&fit=crop',
//       'tablets': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800&auto=format&fit=crop',
//       'tops': 'https://images.unsplash.com/photo-1562157873-818bc0726f68?w=800&auto=format&fit=crop',
//       'vehicle': 'https://images.unsplash.com/photo-1532974297617-c0f05fe48bff?w=800&auto=format&fit=crop',
//       'womens-bags': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop',
//       'womens-dresses': 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=800&auto=format&fit=crop',
//       'womens-jewellery': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&auto=format&fit=crop',
//       'womens-shoes': 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=800&auto=format&fit=crop',
//       'womens-watches': 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&auto=format&fit=crop',
//     };
    
//     // Return the image URL if it exists in the map, otherwise return a default image
//     return categoryImages[slug] ?? 
//         'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=800&auto=format&fit=crop';
//   }

//     // This method returns a color based on the category slug
//   Color getCategoryColor(String slug) {
//     // Using the slug's hashcode to generate a consistent color
//     final int hash = slug.hashCode;
    
//     // Predefined appealing colors for categories
//     final List<Color> colors = [
//       Colors.blue.shade700,
//       Colors.red.shade700,
//       Colors.green.shade700,
//       Colors.orange.shade700,
//       Colors.purple.shade700,
//       Colors.teal.shade700,
//       Colors.pink.shade700,
//       Colors.indigo.shade700,
//       Colors.amber.shade700,
//       Colors.cyan.shade700,
//     ];
    
//     // Use the hash to pick a color from the list
//     return colors[hash.abs() % colors.length];
//   }


//   @override
//   Widget build(BuildContext context) {
//      // Get image URL for this category
//     final imageUrl = getCategoryImage(category.slug);
//     // Get a color for this category (used for gradient and fallback)
//     final categoryColor = getCategoryColor(category.slug);
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductsByCategoryScreen(category: category.slug),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.grey.shade200,
//         ),
//         clipBehavior: Clip.antiAlias,
//         child: Stack(
//           children: [
//             // Image
//             Positioned.fill(
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   // If image fails to load, show a gradient with category icon
//                   return Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           categoryColor,
//                           categoryColor.withOpacity(0.7),
//                         ],
//                       ),
//                     ),
//                     child: Center(
//                       child: getCategoryIcon(category.slug),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Gradient overlay for better text readability
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       Colors.black.withOpacity(0.7),
//                     ],
//                     stops: const [0.6, 1.0],
//                   ),
//                 ),
//               ),
//             ),
//             // Category name overlay
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              
//                 color: Colors.black.withOpacity(0.6),
//                 child: Text(
//                   // Format the category name to look nice
//                   category.name.replaceAll('-', ' '),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
// // Return an appropriate icon for each category
//   Widget getCategoryIcon(String slug) {
//     IconData iconData;
    
//     // Map category slugs to relevant icons
//     switch (slug) {
//       case 'beauty':
//         iconData = Icons.face;
//         break;
//       case 'fragrances':
//         iconData = Icons.spa;
//         break;
//       case 'furniture':
//         iconData = Icons.chair;
//         break;
//       case 'groceries':
//         iconData = Icons.shopping_basket;
//         break;
//       case 'home-decoration':
//         iconData = Icons.home;
//         break;
//       case 'kitchen-accessories':
//         iconData = Icons.kitchen;
//         break;
//       case 'laptops':
//         iconData = Icons.laptop;
//         break;
//       case 'mens-shirts':
//         iconData = Icons.checkroom;
//         break;
//       case 'mens-shoes':
//         iconData = Icons.accessibility;
//         break;
//       case 'mens-watches':
//         iconData = Icons.watch;
//         break;
//       case 'mobile-accessories':
//         iconData = Icons.headset;
//         break;
//       case 'motorcycle':
//         iconData = Icons.motorcycle;
//         break;
//       case 'skin-care':
//         iconData = Icons.face_retouching_natural;
//         break;
//       case 'smartphones':
//         iconData = Icons.smartphone;
//         break;
//       case 'sports-accessories':
//         iconData = Icons.sports_basketball;
//         break;
//       case 'sunglasses':
//         iconData = Icons.golf_course;
//         break;
//       case 'tablets':
//         iconData = Icons.tablet;
//         break;
//       case 'tops':
//         iconData = Icons.checkroom;
//         break;
//       case 'vehicle':
//         iconData = Icons.directions_car;
//         break;
//       case 'womens-bags':
//         iconData = Icons.shopping_bag;
//         break;
//       case 'womens-dresses':
//         iconData = Icons.checkroom;
//         break;
//       case 'womens-jewellery':
//         iconData = Icons.diamond;
//         break;
//       case 'womens-shoes':
//         iconData = Icons.accessibility;
//         break;
//       case 'womens-watches':
//         iconData = Icons.watch;
//         break;
//       default:
//         iconData = Icons.category;
//         break;
//     }
    
//     return Icon(
//       iconData,
//       color: Colors.white,
//       size: 40,
//     );
//   }


// }


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