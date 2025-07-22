import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/cart/presentation/widgets/command_section/command_card_widget.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_widget.dart';
import 'package:legy/features/cart/presentation/widgets/payment_section/payment_widget.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/features/restaurant/presentation/views/all_restaurants_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullCartView extends StatefulWidget {
  static const routePath = 'fullCart';

  const FullCartView({super.key});

  @override
  State<FullCartView> createState() => _FullCartViewState();
}

class _FullCartViewState extends State<FullCartView> {
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    final loadedProducts = cacheHelper.getCartProducts();

    setState(() {
      products = loadedProducts;
    });
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    await cacheHelper.clearCart();
    setState(() {
      products.clear();
    });
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var product in products) {
      total += product.pricePostCom * product.quantity;
      for (var supplement in product.supplements) {
        total += supplement.price * (supplement.quantity ?? 0);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? _buildEmptyView(context)
        : _buildFullCartView(context);
  }

  Widget _buildFullCartView(BuildContext context) {
    final totalPrice = calculateTotalPrice();

    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16),
          child: BlackAppBar(title: 'Mon Panier', onTap: context.pop),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Détails commande',
                          style: TextStyles.textMedium.black1),
                      SizedBox(
                        height: context.width * 0.08,
                        child: ElevatedButton(
                          onPressed: clearCart,
                          style: OutlinedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colours.lightThemeOrange5,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: Text('vider le panier',
                              style: TextStyles.textMedium.white1),
                        ),
                      ),
                    ],
                  ),
                ),
                ...products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommandCardWidget(
                      product: product,
                      supplements: product.supplements,
                      onRemoved: loadCart,
                      onIncrement: () {
                        setState(() {
                          product.quantity++;
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          if (product.quantity > 1) {
                            product.quantity--;
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
                const Gap(20),
                const DetailsWidget(),
                PaymentWidget(totalPrice: totalPrice, products: products),
                const Gap(20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlackAppBar(title: 'Mon Panier', onTap: context.pop),
        ),
        const Gap(100),
        Image.asset(Media.emptyCart),
        const Gap(40),
        Text("Aïe ! J'ai faim !", style: TextStyles.titleMediumSmall.black2),
        const Gap(15),
        SizedBox(
          width: context.width * 0.7,
          height: context.height * 0.1,
          child: AutoSizeText(
            "Il semble que vous n'ayez pas encore commandé de nourriture.",
            textAlign: TextAlign.center,
            style: TextStyles.textMediumLarge.grey1,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: BuildLogInAndRegButton(
            "Trouver des plats",
            "none",
            () => context
                .push('${HomePage.routePath}/${AllRestaurantsView.routePath}'),
          ),
        ),
      ],
    );
  }
}
