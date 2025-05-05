import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/providers/products_notifier_provider.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class CategoriesComponent extends StatefulHookConsumerWidget {
  final List<String> categories;
  final void Function()? onPressed;

  const CategoriesComponent(
      {super.key, required this.categories, this.onPressed});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesComponentState();
}

class _CategoriesComponentState extends ConsumerState<CategoriesComponent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.categories.length,
              (index) => GestureDetector(
                onTap: () async {
                  final fetchProducts = ref.read(productsProvider.notifier);
                  if (widget.categories[index] == "All") {
                    await fetchProducts.fetchAllProducts();
                    setState(() => selectedIndex = 0);
                  } else {
                    await fetchProducts.fetchCategoryProduct(
                      category: widget.categories[index],
                    );
                    setState(() => selectedIndex = index);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(Spacings.spacing10),
                  margin: const EdgeInsets.only(
                    left: Spacings.spacing10,
                  ),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? colors.ggray900
                        : colors.kWhite,
                    borderRadius: BorderRadius.circular(Spacings.spacing20),
                    border: Border.all(
                      color: colors.ggray200,
                    ),
                  ),
                  child: BaseText(
                    widget.categories[index],
                    color: selectedIndex == index
                        ? colors.kWhite
                        : colors.ggray900,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
