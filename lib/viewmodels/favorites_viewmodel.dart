import '../data/models/product.dart';
import 'base_viewmodel.dart';

class FavoritesViewModel extends BaseViewModel {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    final isCurrentlyFavorite = product.isFavorite;
    product.isFavorite = !isCurrentlyFavorite;
    
    if (product.isFavorite) {
      if (!_favorites.any((item) => item.id == product.id)) {
        _favorites.add(product);
      }
    } else {
      _favorites.removeWhere((item) => item.id == product.id);
    }
    
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favorites.any((product) => product.id == productId);
  }

  void removeAllFavorites() {
    for (var product in _favorites) {
      product.isFavorite = false;
    }
    _favorites.clear();
    notifyListeners();
  }
}