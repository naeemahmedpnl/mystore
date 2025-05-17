import '../core/errors/exceptions.dart';
import '../data/repositories/category_repository.dart';
import '../data/models/category.dart';
import './base_viewmodel.dart';

class CategoriesViewModel extends BaseViewModel {
  final CategoryRepository _categoryRepository;
  List<Category> _categories = [];

  CategoriesViewModel({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;

  List<Category> get categories => _categories;

  Future<void> fetchAllCategories() async {
    setState(ViewState.busy);
    try {
      _categories = await _categoryRepository.getAllCategories();
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
