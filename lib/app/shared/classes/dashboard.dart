import 'package:flutter/material.dart';
import 'package:tezda_task/app/modules/products/presentation/pages/favourite_product_page.dart';
import 'package:tezda_task/app/modules/products/presentation/pages/products_page.dart';
import 'package:tezda_task/app/modules/profile/presentation/pages/profile_page.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AppThemeMixin {
  int appCurrIndex = 0;

  List<IconData> navicons = [
    IconlyBroken.bag,
    IconlyBroken.heart,
    IconlyBroken.profile,
  ];

  List<String> navtexts = ['Products', 'Favourites', 'Profile'];

  List<Widget> pages = [
    const ProductsPage(),
    const FavouriteProductPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBackground,
      bottomNavigationBar: Consumer(
        builder: (_, ref, child) {
          return Container(
            height: 85,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: colors.kWhite,
              border:
                  Border(top: BorderSide(color: colors.ggray200, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List<Widget>.generate(
                  pages.length,
                  (int i) {
                    return BottomNavItemComponent(
                      icon: navicons[i],
                      text: navtexts[i],
                      active: appCurrIndex == i,
                      onTap: () {
                        setState(() {
                          appCurrIndex = i;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: Container(
        child: pages[appCurrIndex],
      ),
    );
  }
}
