import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/products_controller.dart';
import 'package:tezda_task/app/shared/shared.dart';

final fetchCategoriesProvider =
    StateNotifierProvider<CategoryNotifier, List<String>>(
  (ref) => CategoryNotifier(),
);

class CategoryNotifier extends StateNotifier<List<String>> {
  CategoryNotifier() : super([]);

  final _productsController = ProductsController();

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await _productsController.fetchCategories();

      final Set<String> categoriesSet =
          fetchedCategories.map((category) => category.name).toSet();

      final List<String> categories = categoriesSet.toList();

      state = categories;
    } catch (error) {
      log('Error fetching products: $error');
    }
  }
}
