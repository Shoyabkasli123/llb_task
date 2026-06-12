import 'package:get/get.dart';
import 'package:llb_task/data/api/api_checker.dart';
import 'package:llb_task/data/model/response/product_model.dart';
import 'package:llb_task/data/repo/product_repo.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<Products> _productList = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  double _maxPrice = 5000;
  bool _isLoading = false;
  bool _hasMore = true;
  int _pageSize = 10;
  int _skip = 0;

  List<Products> get productList => _productList;
  String get searchQuery => _searchQuery;
  List<Products> _filteredProductList = [];
  List<Products> get filteredProductList => _filteredProductList;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  double get maxPrice => _maxPrice;

  Future<void> getProductList({bool reload = false}) async {
    if (_isLoading) return;

    if (reload) {
      _productList.clear();
      _filteredProductList.clear();
      _skip = 0;
      _hasMore = true;
    }

    if (!_hasMore) return;

    _isLoading = true;
    update();

    Response response = await productRepo.getAllProductList(
      limit: _pageSize,
      skip: _skip,
    );

    if (response.statusCode == 200) {
      ProductModel model = ProductModel.fromJson(response.body);

      if (model.products != null) {
        _productList.addAll(model.products!);
        applyFilters();

        _skip += _pageSize;

        if (model.products!.length < _pageSize) {
          _hasMore = false;
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }

  List<String> get categories {
    final categoryList = _productList
        .map((e) => e.category ?? '')
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    categoryList.sort();

    return ['All', ...categoryList];
  }
  bool get isFilterApplied =>
      _searchQuery.isNotEmpty ||
          _selectedCategory != 'All' ||
          _maxPrice < 5000;

  void applyFilters() {
    _filteredProductList = _productList.where((product) {
      final title = (product.title ?? '').toLowerCase();

      final category = (product.category ?? '').toLowerCase();

      final searchMatch = title.contains(_searchQuery.toLowerCase());

      final categoryMatch =
          _selectedCategory == 'All' ||
              category == _selectedCategory.toLowerCase();

      final priceMatch = (product.price ?? 0) <= _maxPrice;

      return searchMatch && categoryMatch && priceMatch;
    }).toList();

    update();
  }
  void changeCategory(String category) {
    _selectedCategory = category;
    applyFilters();
  }

  void changePrice(double price) {
    _maxPrice = price;
    applyFilters();
  }

  void searchProduct(String query) {
    _searchQuery = query;
    applyFilters();
  }

}
