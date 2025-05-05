import 'package:tezda_task/app/modules/products/domain/service/products_service.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/injection.dart';

class ProductsRepository {
  final _productsService = inj<ProductsService>();

  Future<ApiResponse> fetchAllProducts() async {
    return _productsService.fetchAllProducts();
  }

  Future<ApiResponse> fetchCategories() async {
    return _productsService.fetchCategories();
  }
}
