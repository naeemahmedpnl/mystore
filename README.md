#  Flutter Product App

A Flutter app that showcases products fetched from a dummy API with features like category filtering, product details, search functionality, and favorites management.

---
## App Demo
![App Demo](assets/flutter_product_app_demo.mp4)

## APIs Used

- **Products List**: [https://dummyjson.com/products?limit=100](https://dummyjson.com/products?limit=100)
- **Single Product**: `https://dummyjson.com/products/{productId}`
- **Categories List**: [https://dummyjson.com/products/categories](https://dummyjson.com/products/categories)

---

## Features

- Splash screen on app launch.
- Bottom navigation with 4 tabs:
  1. **Products** – Displays all products.
  2. **Categories** – Lists all product categories.
  3. **Favorites** – Displays list of favorited products.
  4. **User** – Hardcoded screen with developer's name.

- **Search** – Available across product listings.
- **Live Data Fetching** – From the DummyJSON API.
- **Category Filtering** – Filter products based on selected category.
- **Product Details View** – See full details and mark as favorite.
- **Favorites Management** – Add/remove products to/from favorites using state management (no persistent storage).

---

##  Getting Started

### Prerequisites

- Flutter SDK
- Android Studio or VS Code
- Emulator or connected device

### Steps

```bash
git clone https://github.com/your-username/flutter-product-app.git
cd flutter-product-app
flutter pub get
flutter run
