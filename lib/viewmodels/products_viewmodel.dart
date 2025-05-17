import '../core/errors/exceptions.dart';
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
    } on ApiException catch (e) {
      setErrorMessage(_getErrorMessage(e));
      setState(ViewState.error);
    } catch (e) {
      setErrorMessage('An unexpected error occurred. Please try again later.');
      setState(ViewState.error);
    }
  }

  Future<void> fetchProductById(int id) async {
    setState(ViewState.busy);
    try {
      _selectedProduct = await _productRepository.getProductById(id);
      setState(ViewState.idle);
    } on ApiException catch (e) {
      setErrorMessage(_getErrorMessage(e));
      setState(ViewState.error);
    } catch (e) {
      setErrorMessage('An unexpected error occurred. Please try again later.');
      setState(ViewState.error);
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    setState(ViewState.busy);
    try {
      _products = await _productRepository.getProductsByCategory(category);
      setState(ViewState.idle);
    } on ApiException catch (e) {
      setErrorMessage(_getErrorMessage(e));
      setState(ViewState.error);
    } catch (e) {
      setErrorMessage('An unexpected error occurred. Please try again later.');
      setState(ViewState.error);
    }
  }

  String _getErrorMessage(ApiException e) {
    if (e.message.contains('SocketException') ||
        e.message.contains('Failed host lookup')) {
      return 'No internet connection or server not reachable. Please check your connection and try again.';
    } else if (e.statusCode == 404) {
      return 'The requested resource was not found.';
    } else if (e.statusCode == 500) {
      return 'Server error. Please try again later.';
    }
    return e.message;
  }
}
