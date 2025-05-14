# PowerShell script to create Flutter MVVM folder structure

# Create main files
New-Item -Path "lib" -ItemType Directory -Force
New-Item -Path "lib\main.dart" -ItemType File -Force
New-Item -Path "lib\app.dart" -ItemType File -Force

# Create core structure
New-Item -Path "lib\core\constants" -ItemType Directory -Force
New-Item -Path "lib\core\errors" -ItemType Directory -Force
New-Item -Path "lib\core\utils" -ItemType Directory -Force
New-Item -Path "lib\core\constants\api_constants.dart" -ItemType File -Force
New-Item -Path "lib\core\errors\exceptions.dart" -ItemType File -Force
New-Item -Path "lib\core\utils\navigator_service.dart" -ItemType File -Force

# Create data structure
New-Item -Path "lib\data\models" -ItemType Directory -Force
New-Item -Path "lib\data\repositories" -ItemType Directory -Force
New-Item -Path "lib\data\services" -ItemType Directory -Force
New-Item -Path "lib\data\models\product.dart" -ItemType File -Force
New-Item -Path "lib\data\models\category.dart" -ItemType File -Force
New-Item -Path "lib\data\repositories\product_repository.dart" -ItemType File -Force
New-Item -Path "lib\data\repositories\category_repository.dart" -ItemType File -Force
New-Item -Path "lib\data\services\api_service.dart" -ItemType File -Force

# Create UI structure
New-Item -Path "lib\ui\views\splash" -ItemType Directory -Force
New-Item -Path "lib\ui\views\home" -ItemType Directory -Force
New-Item -Path "lib\ui\views\products" -ItemType Directory -Force
New-Item -Path "lib\ui\views\categories" -ItemType Directory -Force
New-Item -Path "lib\ui\views\favorites" -ItemType Directory -Force
New-Item -Path "lib\ui\views\user" -ItemType Directory -Force
New-Item -Path "lib\ui\widgets" -ItemType Directory -Force
New-Item -Path "lib\ui\common" -ItemType Directory -Force

# Create view files
New-Item -Path "lib\ui\views\splash\splash_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\home\home_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\products\products_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\products\product_details_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\categories\categories_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\categories\products_by_category_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\favorites\favorites_screen.dart" -ItemType File -Force
New-Item -Path "lib\ui\views\user\user_screen.dart" -ItemType File -Force

# Create widget files
New-Item -Path "lib\ui\widgets\product_card.dart" -ItemType File -Force
New-Item -Path "lib\ui\widgets\category_card.dart" -ItemType File -Force

# Create common files
New-Item -Path "lib\ui\common\app_colors.dart" -ItemType File -Force
New-Item -Path "lib\ui\common\app_theme.dart" -ItemType File -Force

# Create viewmodel structure
New-Item -Path "lib\viewmodels" -ItemType Directory -Force
New-Item -Path "lib\viewmodels\base_viewmodel.dart" -ItemType File -Force
New-Item -Path "lib\viewmodels\products_viewmodel.dart" -ItemType File -Force
New-Item -Path "lib\viewmodels\categories_viewmodel.dart" -ItemType File -Force
New-Item -Path "lib\viewmodels\favorites_viewmodel.dart" -ItemType File -Force

Write-Host "Flutter MVVM folder structure created successfully!" -ForegroundColor Green