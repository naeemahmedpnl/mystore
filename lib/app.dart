// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/views/splash/splash_screen.dart';
import 'viewmodels/products_viewmodel.dart';
import 'viewmodels/categories_viewmodel.dart';
import 'viewmodels/favorites_viewmodel.dart';
import 'ui/common/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriesViewModel()),
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
      ],
      child: MaterialApp(
        title: 'My Store',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}