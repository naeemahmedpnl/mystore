// Update the error state in ProductsScreen
import 'package:flutter/material.dart';
import 'package:my_store/core/errors/exceptions.dart';
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
  bool _errorDialogShown = false; // Add this flag

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
              Center(
                child: const Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                      // Show error dialog when error occurs
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!_errorDialogShown) {
                          _errorDialogShown = true;
                          ErrorDialog.show(
                            context,
                            title: 'Connection Error',
                            message: viewModel.errorMessage,
                            onRetry: () {
                              _errorDialogShown = false;
                              viewModel.fetchAllProducts();
                            },
                          );
                        }
                      });

                      // Show an error UI on the screen
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_off,
                              color: Colors.grey,
                              size: 80,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Unable to load products',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              viewModel.errorMessage,
                              style: TextStyle(color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                _errorDialogShown = false;
                                viewModel.fetchAllProducts();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Reset error dialog flag when we have successful data
                      _errorDialogShown = false;

                      // Filter products based on search query
                      final filteredProducts =
                          viewModel.products.where((product) {
                        return product.title
                                .toLowerCase()
                                .contains(_searchQuery) ||
                            product.description
                                .toLowerCase()
                                .contains(_searchQuery) ||
                            product.category
                                .toLowerCase()
                                .contains(_searchQuery) ||
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
                                return ProductListCard(
                                    product: filteredProducts[index]);
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
