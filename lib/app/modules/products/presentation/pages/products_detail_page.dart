import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/products/data/models/product_model.dart';
import 'package:tezda_task/app/modules/products/domain/controllers/providers/products_notifier_provider.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class ProductDetailPage extends HookConsumerWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeBuilder(
      builder: (colors) {
        return Scaffold(
          backgroundColor: colors.kBackground,
          appBar: const AppBarComponent(
            title: "Product Detail",
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: [
                              FanCarouselImageSlider.sliderType2(
                                imagesLink: verifyUrl(product.images[0])
                                    ? product.images
                                    : [Pngs.productPlaceHolder],
                                isAssets: false,
                                autoPlay: false,
                                sliderHeight: 300,
                                currentItemShadow: const [],
                                sliderDuration:
                                    const Duration(milliseconds: 200),
                                imageRadius: 0,
                                slideViewportFraction: 1.2,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BaseText(
                                      product.category,
                                      color: colors.ggray500,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(productsProvider.notifier)
                                              .toggleFavorite(product.id);
                                        },
                                        child: product.isFavorite
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
                                BaseText(
                                  product.title,
                                  color: colors.ggray900,
                                  fontSize: TextSizes.size20,
                                  fontWeight: FontWeight.w600,
                                ),
                                const VSpacer(Spacings.spacing4),
                                BaseText(
                                  formatAmount(product.price),
                                  color: colors.tF9A03F,
                                  fontSize: TextSizes.size18,
                                  fontWeight: FontWeight.w600,
                                ),
                                const VSpacer(Spacings.spacing20),
                                BaseText(
                                  formatAmount(product.description),
                                  color: colors.ggray400,
                                  fontSize: TextSizes.size16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacings.spacing10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: "Add to Cart",
                    onPressed: () {},
                    color: colors.kBackground,
                    textColor: colors.ggray900,
                    borderColor: colors.ggray900,
                  ),
                  CustomButton(
                    text: "Buy Now",
                    color: colors.ggray900,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: Spacings.spacing24),
            ],
          ),
        );
      },
    );
  }
}
