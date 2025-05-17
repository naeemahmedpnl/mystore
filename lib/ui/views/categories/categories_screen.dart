// Update the error state in CategoriesScreen
import 'package:flutter/material.dart';
import 'package:my_store/core/errors/exceptions.dart';
import 'package:my_store/ui/widgets/category_gird_card.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/categories_viewmodel.dart';
import '../../../viewmodels/base_viewmodel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _errorDialogShown = false; // Add this flag

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoriesViewModel>(context, listen: false)
          .fetchAllCategories();
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Center(
                child: const Text(
                  'Categories',
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
                    hintText: 'Search categories',
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
                child: Consumer<CategoriesViewModel>(
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
                              viewModel.fetchAllCategories();
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
                              'Unable to load categories',
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
                                viewModel.fetchAllCategories();
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

                      // Filter categories based on search query
                      final filteredCategories =
                          viewModel.categories.where((category) {
                        return category.name
                            .toLowerCase()
                            .contains(_searchQuery);
                      }).toList();

                      // Display number of results found and categories grid
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${filteredCategories.length} results found',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: filteredCategories.length,
                              itemBuilder: (context, index) {
                                return CategoryGridCard(
                                    category: filteredCategories[index]);
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
