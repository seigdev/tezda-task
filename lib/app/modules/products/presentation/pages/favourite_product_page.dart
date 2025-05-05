import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/providers/products_notifier_provider.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class FavouriteProductPage extends HookConsumerWidget {
  const FavouriteProductPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.read(productsProvider.notifier);
    return ThemeBuilder(builder: (colors) {
      return Scaffold(
        appBar: const AppBarComponent(
          hasLeading: true,
          title: "Favourite Product",
          centerTitle: true,
        ),
        backgroundColor: colors.kBackground,
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: products.fetchFavoritesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularLoadingComponent(
                color: colors.tF9A03F,
              ));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: BaseText(
                  'No favorites found.',
                  fontWeight: FontWeight.w600,
                  fontSize: TextSizes.size18,
                ),
              );
            }

            final favoriteProducts = snapshot.data!;

            return ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                log(product["isFavorite"]);
                return ListTile(
                  leading: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      product["images"][0],
                    ),
                  ),
                  title: BaseText(product["title"]),
                  subtitle: BaseText(
                    formatAmount(product["price"]),
                    color: colors.tF9A03F,
                    fontSize: TextSizes.size18,
                    fontWeight: FontWeight.w700,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      product["isFavorite"]
                          ? IconlyBold.heart
                          : IconlyBroken.heart,
                      color: product["isFavorite"] ? colors.tF9A03F : null,
                    ),
                    onPressed: () {
                      products.toggleFavorite(product["id"]);
                    },
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
