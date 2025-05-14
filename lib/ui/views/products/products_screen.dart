
// lib/ui/views/products/products_screen.dart
import 'package:flutter/material.dart';
import 'package:my_store/ui/widgets/product_list_card.dart';

import 'package:provider/provider.dart';
import '../../../viewmodels/products_viewmodel.dart';
import '../../../viewmodels/base_viewmodel.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsViewModel>(context, listen: false).fetchAllProducts();
    });
  }

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
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Products',
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
                    hintText: 'LipStick',

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
                child: Consumer<ProductsViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.state == ViewState.busy) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.state == ViewState.error) {
                      return Center(
                        child: Text(
                          'Error: ${viewModel.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      // Filter products based on search query
                      final filteredProducts = viewModel.products.where((product) {
                        return product.title.toLowerCase().contains(_searchQuery) ||
                               product.description.toLowerCase().contains(_searchQuery) ||
                               product.category.toLowerCase().contains(_searchQuery) ||
                               product.brand.toLowerCase().contains(_searchQuery);
                      }).toList();
                      
                      // Display number of results found and products list
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${filteredProducts.length} results found',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                return ProductListCard(product: filteredProducts[index]);
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