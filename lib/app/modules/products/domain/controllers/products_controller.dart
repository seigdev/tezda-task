import 'package:tezda_task/app/modules/products/data/models/product_model.dart';
import 'package:tezda_task/app/modules/products/domain/repository/products_repository.dart';

class ProductsController {
  final _productsRepository = ProductsRepository();

  Future<List<Product>> fetchAllProducts() async {
    final res = await _productsRepository.fetchAllProducts();

    final List data = res.data;

    List<Product> products = data.map((e) => Product.fromJson(e)).toList();

    return products;
  }

  Future<List<Category>> fetchCategories() async {
    final res = await _productsRepository.fetchCategories();

    final List data = res.data;

    List<Category> products = data.map((e) => Category.fromJson(e)).toList();

    return products;
  }
}
