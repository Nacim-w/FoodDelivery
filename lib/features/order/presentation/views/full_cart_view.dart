import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/order/presentation/views/empty_cart_view.dart';
import 'package:legy/features/order/presentation/widgets/command_section/command_card_widget.dart';
import 'package:legy/features/order/presentation/widgets/details_section/details_widget.dart';
import 'package:legy/features/order/presentation/widgets/payment_section/payment_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullCartView extends StatefulWidget {
  static const routePath = 'fullCart';

  const FullCartView({super.key});

  @override
  State<FullCartView> createState() => _FullCartWidgetState();
}

class _FullCartWidgetState extends State<FullCartView> {
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
    if (loadedProducts.isEmpty) {
      // ignore: use_build_context_synchronously
      context.go('${HomePage.routePath}/${EmptyCartView.routePath}');
      return;
    }

    setState(() {
      products = loadedProducts;
    });
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var product in products) {
      debugPrint("${product.pricePostCom}");

      total += product.pricePostCom * product.quantity;
      for (var supplement in product.supplements) {
        print(supplement.price);
        total += supplement.price * (supplement.quantity ?? 0);
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();

    return Column(
      children: [
        Gap(40),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ProfileSettingsAppbar(title: 'Mon Panier'),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommandCardWidget(
                      product: product,
                      supplements: product.supplements,
                      onRemoved: () {
                        // Reload the cart when a product is removed
                        loadCart();
                      }, // linked supplements
                    ),
                  );
                }),
                Gap(20),
                DetailsWidget(),
                PaymentWidget(totalPrice: totalPrice, products: products),
                Gap(20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
