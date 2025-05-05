import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/data/models/product_model.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/products_controller.dart';
import 'package:tezda_task/app/modules/profile/data/models/user_model.dart';
import 'package:tezda_task/app/shared/shared.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier, List<Product>>(
  (ref) => ProductsNotifier(),
);

final addedToFavourite = StateProvider((ref) => null);

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]);

  final _productsController = ProductsController();

  Future<void> fetchAllProducts() async {
    try {
      final fetchedProducts = await _productsController.fetchAllProducts();

      state = fetchedProducts;
    } catch (error) {
      log('Error fetching products: $error');
    }
  }

  Future<void> fetchCategoryProduct({required String category}) async {
    try {
      final fetchedProducts = await _productsController.fetchAllProducts();

      final categoryProduct = fetchedProducts
          .where((item) =>
              item.category.toLowerCase().contains(category.toLowerCase()))
          .toList();

      state = categoryProduct;
    } catch (error) {
      log('Error fetching products: $error');
    }
  }

  void toggleFavorite(int productId) async {
    final updatedProducts = [
      for (final product in state)
        if (product.id == productId)
          Product(
            id: product.id,
            title: product.title,
            isFavorite: !product.isFavorite,
            price: product.price,
            description: product.description,
            images: product.images,
            category: product.category,
            discountPercentage: product.discountPercentage,
            rating: product.rating,
            stock: product.stock,
            tags: product.tags,
            brand: product.brand,
            sku: product.sku,
            weight: product.weight,
            dimensions: product.dimensions,
            warrantyInformation: product.warrantyInformation,
            shippingInformation: product.shippingInformation,
            availabilityStatus: product.availabilityStatus,
            reviews: product.reviews,
            returnPolicy: product.returnPolicy,
            minimumOrderQuantity: product.minimumOrderQuantity,
            meta: product.meta,
            thumbnail: product.thumbnail,
          )
        else
          product
    ];

    final updatedProduct =
        updatedProducts.firstWhere((product) => product.id == productId);

    state = updatedProducts;

    try {
      if (updatedProduct.isFavorite) {
        await addToFavorites(updatedProduct);
      } else {
        await removeFromFavorites(updatedProduct.id);
      }
    } catch (e) {
      log('Error updating favorites: $e');
    }
  }

  Future<void> loadFavoritesFromStorage() async {
    for (int i = 0; i < state.length; i++) {
      bool isFavorite = CacheData.fetchBool('product_${state[i].id}') ?? false;
      state[i] = state[i].copyWith(isFavorite: isFavorite);
    }
  }

  Future<void> addToFavorites(Product product) async {
    try {
      await FIRESTORE.firestore
          .collection('users')
          .doc(UserModel.userId)
          .collection('favorites')
          .doc(product.id.toString())
          .set({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'images': product.images,
        'category': product.category,
        'isFavorite': true,
      });

      await CacheData.save('product_${product.id}',
          state.firstWhere((p) => p.id == product.id).isFavorite);

      log('Product added to favorites successfully');
      showSuccessToast("item added to favourite");
    } catch (e) {
      showErrorToast("error adding item added to favourite");
      log('Error adding product to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(int productId) async {
    try {
      await FIRESTORE.firestore
          .collection('users')
          .doc(UserModel.userId)
          .collection('favorites')
          .doc(productId.toString())
          .delete();

      await CacheData.remove(
        'product_$productId',
      );

      log('Product removed from favorites successfully');
      showSuccessToast("item removed to favourite");
    } catch (e) {
      showErrorToast("error removing item from favourite");
      log('Error removing product from favorites: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> fetchFavoritesStream() {
    return FIRESTORE.firestore
        .collection('users')
        .doc(UserModel.userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
