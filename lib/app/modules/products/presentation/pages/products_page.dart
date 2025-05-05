import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/data/models/product_model.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/providers/category_notifier_provider.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/providers/products_notifier_provider.dart';
import 'package:tezda_task/app/modules/products/presentation/components/categories_component.dart';
import 'package:tezda_task/app/modules/products/presentation/components/product_component.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class ProductsPage extends StatefulHookConsumerWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage>
    with AppThemeMixin {
  bool loading = false;

  final TextEditingController searchController = TextEditingController();

  List<Product> filteredProducts = [];

  bool productExist = true;

  @override
  void initState() {
    super.initState();
    setState(() => loading = true);
    fetchCategories();
  }

  void fetchCategories() async {
    final fetchCategories = ref.read(fetchCategoriesProvider.notifier);
    await fetchCategories.fetchCategories();
    fetchProducts();
  }

  void fetchProducts() async {
    final fetchProducts = ref.read(productsProvider.notifier);
    await fetchProducts.fetchAllProducts();
    await fetchProducts.loadFavoritesFromStorage();
    setState(() => loading = false);
  }

  void filterItems(List<Product> items, String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() => filteredProducts = items);
    } else {
      setState(() {
        filteredProducts = items
            .where((item) =>
                item.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      });
      if (filteredProducts.isEmpty) {
        setState(() => productExist = false);
      } else {
        setState(() => productExist = true);
        log(filteredProducts.toList());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    final categories = ref.watch(fetchCategoriesProvider);

    return Scaffold(
      backgroundColor: colors.kBackground,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        children: [
                          const VSpacer(Spacings.spacing20),
                          const BaseText(
                            "Products Listing",
                            fontSize: TextSizes.size18,
                            fontWeight: FontWeight.w600,
                          ),
                          const VSpacer(Spacings.spacing24),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFieldComponent(
                              editingController: searchController,
                              hint: 'Search for Products',
                              prefix: SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  IconlyBroken.search,
                                  color: colors.ggray500,
                                ),
                              ),
                              borderRadius: Spacings.spacing24,
                              onChanged: (value) {
                                filterItems(products, value);
                              },
                            ),
                          ),
                          const VSpacer(Spacings.spacing24),
                          CategoriesComponent(
                            categories: ["All", ...categories],
                          ),
                          const VSpacer(Spacings.spacing24),
                        ],
                      ),
                    ],
                  ),
                ),
                products.isNotEmpty
                    ? productExist
                        ? SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0,
                              childAspectRatio: 1,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Center(
                                  child: ProductComponent(
                                    product: filteredProducts.isEmpty
                                        ? products[index]
                                        : filteredProducts[index],
                                  ),
                                );
                              },
                              childCount: filteredProducts.isEmpty
                                  ? products.length
                                  : filteredProducts.length,
                            ),
                          )
                        : SliverFillRemaining(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const BaseText(
                                  "Product Not Found",
                                  fontWeight: FontWeight.w600,
                                ),
                                BaseText(
                                  "Try searching something else.",
                                  color: colors.ggray400,
                                )
                              ],
                            ),
                          )
                    : SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const BaseText(
                              "Products Not Available",
                              fontWeight: FontWeight.w600,
                            ),
                            BaseText(
                              "Try searching something else.",
                              color: colors.ggray400,
                            )
                          ],
                        ),
                      ),
              ],
            )
            // : const CircularLoadingComponent(),
            ),
      ),
    );
  }
}
