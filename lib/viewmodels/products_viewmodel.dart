import '../data/models/product.dart';
import '../data/repositories/product_repository.dart';
import 'base_viewmodel.dart';

class ProductsViewModel extends BaseViewModel {
  final ProductRepository _productRepository = ProductRepository();
  List<Product> _products = [];
  Product? _selectedProduct;

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;

  Future<void> fetchAllProducts() async {
    setState(ViewState.busy);
    try {
      _products = await _productRepository.getAllProducts();
      setState(ViewState.idle);
    } catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    }
  }

  Future<void> fetchProductById(int id) async {
    setState(ViewState.busy);
    try {
      _selectedProduct = await _productRepository.getProductById(id);
      setState(ViewState.idle);
    } catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    setState(ViewState.busy);
    try {
      _products = await _productRepository.getProductsByCategory(category);
      setState(ViewState.idle);
    } catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    }
  }
}
