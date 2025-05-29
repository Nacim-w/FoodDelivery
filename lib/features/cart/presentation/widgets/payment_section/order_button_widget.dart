import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/cart/presentation/app/order_cubit.dart';
import 'package:legy/features/cart/presentation/app/order_state.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderButtonWidget extends StatelessWidget {
  const OrderButtonWidget({
    super.key,
    required this.totalPrice,
    required this.products,
  });

  final double totalPrice;
  final List<ProductModel> products;

  Future<HomeProfileModel?> _getCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    return cacheHelper.getCachedUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colours.lightThemeWhite1,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(100),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$totalPrice CFA', style: TextStyles.titleMediumSmallest),
              GestureDetector(
                onTap: state.isLoading
                    ? null
                    : () async {
                        final prefs = await SharedPreferences.getInstance();
                        final cacheHelper = CacheHelper(prefs);
                        final profile = await _getCachedProfile();

                        if (profile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Profil introuvable. Veuillez vous reconnecter.',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        try {
                          await context
                              .read<OrderCubit>()
                              .placeOrder(products: products, profile: profile);

                          // Clear the cart
                          cacheHelper.clearCart();

                          // SUCCESS snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('✅ Commande passée avec succès!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          context.go(HomePage.routePath);
                        } catch (e) {
                          // FAILURE snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '❌ Échec de la commande: ${e.toString()}',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  decoration: BoxDecoration(
                    color: state.isLoading
                        ? Colors.grey
                        : Colours.lightThemeOrange5,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Center(
                    child: state.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Passer la commande",
                            textAlign: TextAlign.center,
                            style: TextStyles.textSemiBoldLargest.white1,
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
