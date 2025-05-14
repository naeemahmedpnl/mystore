import '../data/models/category.dart';
import '../data/repositories/category_repository.dart';
import 'base_viewmodel.dart';

class CategoriesViewModel extends BaseViewModel {
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<Category> _categories = [];
  String? _selectedCategory;

  List<Category> get categories => _categories;
  String? get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchAllCategories() async {
    setState(ViewState.busy);
    try {
      _categories = await _categoryRepository.getAllCategories();
      setState(ViewState.idle);
    } catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    }
  }
}