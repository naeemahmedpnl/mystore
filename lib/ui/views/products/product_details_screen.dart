
import 'package:flutter/material.dart';
import 'package:my_store/viewmodels/base_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/products_viewmodel.dart';
import '../../../viewmodels/favorites_viewmodel.dart';
import '../../../data/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsViewModel>(context, listen: false)
          .fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Consumer<ProductsViewModel>(
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
          } else if (viewModel.selectedProduct == null) {
            return const Center(child: Text('Product not found'));
          } else {
            final product = viewModel.selectedProduct!;
            return _buildProductDetails(product);
          }
        },
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Images
          SizedBox(
            height: 300,
            child: PageView.builder(
              itemCount: product.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  product.images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        favoritesViewModel.toggleFavorite(product);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (product.discountPercentage > 0)
                  Text(
                    '${product.discountPercentage.toStringAsFixed(0)}% off',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 16),
                const Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Brand', product.brand),
                _buildInfoRow('Category', product.category),
                _buildInfoRow('Rating', '${product.rating}/5'),
                _buildInfoRow('Stock', product.stock.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
