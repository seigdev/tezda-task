import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/data/models/product_model.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/providers/products_notifier_provider.dart';
import 'package:tezda_task/app/modules/products/presentation/pages/products_detail_page.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class ProductComponent extends HookConsumerWidget {
  final Product product;
  const ProductComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ProductItem(
      title: product.title,
      image: product.images,
      price: product.price.toDouble(),
      isFavourite: product.isFavorite,
      onPressed: () async {
        pushTo(ProductDetailPage(product: product));
      },
      isFavouriteTap: () {
        ref.read(productsProvider.notifier).toggleFavorite(product.id);
      },
    );
  }
}

class _ProductItem extends StatefulWidget {
  final double price;
  final String title;
  final List<String> image;
  final void Function() isFavouriteTap;
  final bool isFavourite;
  final void Function()? onPressed;
  const _ProductItem({
    required this.title,
    required this.image,
    this.price = 0.5,
    this.onPressed,
    required this.isFavouriteTap,
    required this.isFavourite,
  });

  @override
  State<_ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<_ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return GestureDetector(
          onTap: widget.onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 300,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.ggray100),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.network(
                      verifyUrl(widget.image[0])
                          ? widget.image[0]
                          : Pngs.productPlaceHolder,
                      width: 500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: widget.isFavouriteTap,
                      child: widget.isFavourite
                          ? Icon(
                              IconlyBold.heart,
                              color: colors.tF9A03F,
                            )
                          : Icon(
                              IconlyBroken.heart,
                              color: colors.ggray200,
                            ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(Spacings.spacing12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      widget.title.truncateWithEllipsis(35),
                      color: colors.ggray900,
                      fontWeight: FontWeight.w600,
                    ),
                    const VSpacer(Spacings.spacing12),
                    BaseText(
                      formatAmount(widget.price),
                      color: colors.tF9A03F,
                      fontSize: TextSizes.size16,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
