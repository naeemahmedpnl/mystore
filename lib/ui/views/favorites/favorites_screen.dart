import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/favorites_viewmodel.dart';
import '../../widgets/favorite_list_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                'Favourites',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Search field
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search ',
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    isDense: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Content
              Expanded(
                child: Consumer<FavoritesViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.favorites.isEmpty) {
                      return const Center(
                        child: Text(
                          'No favorites yet!',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else {
                      // Filter favorites based on search query
                      final filteredFavorites = viewModel.favorites.where((product) {
                        return product.title.toLowerCase().contains(_searchQuery) ||
                               product.description.toLowerCase().contains(_searchQuery) ||
                               product.category.toLowerCase().contains(_searchQuery) ||
                               product.brand.toLowerCase().contains(_searchQuery);
                      }).toList();
                      
                      // Display number of results found and favorites list
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${filteredFavorites.length} results found',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: filteredFavorites.length,
                              itemBuilder: (context, index) {
                                return FavoriteListItem(product: filteredFavorites[index]);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
