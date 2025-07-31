import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/maps/presentation/view/map_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/features/maps/model/saved_location_model.dart';
import 'package:legy/features/cart/presentation/app/order_cubit.dart';
import 'package:legy/features/cart/presentation/app/order_state.dart';

class DetailsLocation extends StatefulWidget {
  const DetailsLocation({
    super.key,
    required this.from,
    required this.to,
    required this.onLocationSelected,
  });

  final String from;
  final String to;
  final Function(String name, double latitude, double longitude)
      onLocationSelected;

  @override
  State<DetailsLocation> createState() => _DetailsLocationWidgetState();
}

class _DetailsLocationWidgetState extends State<DetailsLocation>
    with SingleTickerProviderStateMixin {
  late CacheHelper _cacheHelper;
  bool _initialized = false;

  late AnimationController _controller;
  late Animation<Color?> _borderColorAnimation;
  late Animation<double> _borderWidthAnimation;

  @override
  void initState() {
    super.initState();
    _initCache();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _borderColorAnimation = ColorTween(
      begin: const Color.fromARGB(150, 126, 126, 126),
      end: Colors.redAccent,
    ).animate(_controller);

    _borderWidthAnimation = Tween<double>(
      begin: 1.5,
      end: 2.5,
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initCache() async {
    final prefs = await SharedPreferences.getInstance();
    _cacheHelper = CacheHelper(prefs);
    setState(() {
      _initialized = true;
    });
  }

  void _flashError() {
    if (_controller.isAnimating) {
      _controller.reset();
    }
    _controller.forward(from: 0);
  }

  void _showLocationBottomSheet() async {
    if (!_initialized) return;

    final savedLocations = _cacheHelper.getSavedLocations();
    List<SavedLocation> locations = List.from(savedLocations);

    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colours.lightThemeWhite1.withAlpha(225),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final double sheetHeight =
                MediaQuery.of(context).size.height * 0.35;

            if (locations.isEmpty) {
              return SizedBox(
                height: sheetHeight,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_off,
                          size: 48, color: Colours.lightThemeGrey3),
                      Gap(16),
                      Text('Aucun emplacement enregistré',
                          style: TextStyles.textBoldLarge.black1),
                      Gap(12),
                      Text(
                        'Vous pouvez en ajouter en cliquant sur un point dans la carte.',
                        style: TextStyles.textMediumLarge.grey1,
                        textAlign: TextAlign.center,
                      ),
                      Gap(20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colours.lightThemeOrange5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          context
                              .go('${HomePage.routePath}/${MapView.routePath}');
                        },
                        child: Text('Aller à la carte',
                            style: TextStyles.textMediumLarge.white1),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SizedBox(
              height: sheetHeight,
              child: Column(
                children: [
                  Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      itemCount: locations.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colours.lightThemeGrey2),
                          ),
                          leading: Icon(Icons.location_on,
                              color: Colours.lightThemeOrange5),
                          title: Text(
                            location.name,
                            style: TextStyles.textSemiBoldLarge.black1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            '(${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)})',
                            style: TextStyles.textMediumLarge.grey1,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.close,
                                size: 20, color: Colours.lightThemeGrey3),
                            onPressed: () async {
                              locations.removeAt(index);
                              await _cacheHelper.cacheSavedLocations(locations);
                              setModalState(() {});
                              setState(() {});
                            },
                            tooltip: "Supprimer",
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            widget.onLocationSelected(location.name,
                                location.latitude, location.longitude);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.lightThemeOrange5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        context
                            .go('${HomePage.routePath}/${MapView.routePath}');
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text('Ajouter un emplacement',
                              style: TextStyles.textMediumLarge.white1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listenWhen: (previous, current) =>
          previous.locationError != current.locationError,
      listener: (context, state) {
        if (state.locationError) {
          _flashError();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _borderColorAnimation.value ??
                      const Color.fromARGB(126, 126, 126, 126),
                  width: _borderWidthAnimation.value,
                ),
                boxShadow: _controller.status == AnimationStatus.forward ||
                        _controller.status == AnimationStatus.completed
                    ? [
                        BoxShadow(
                          color:
                              (_borderColorAnimation.value ?? Colors.redAccent)
                                  .withAlpha(25),
                          blurRadius: 3,
                          spreadRadius: 1.5,
                        ),
                      ]
                    : null,
              ),
              child: ListTile(
                leading: SvgPicture.asset(
                  width: 26,
                  height: 26,
                  Media.paymentLocation,
                  colorFilter: ColorFilter.mode(
                    Colours.lightThemeOrange5,
                    BlendMode.srcIn,
                  ),
                ),
                title: Text(
                  "${widget.from} -> ${widget.to}",
                  style: TextStyles.textSemiBold.black1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text("Cliquez pour choisir un emplacement",
                    style: TextStyles.textMediumSmall.black1),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: Colours.lightThemeGrey1),
                onTap: _showLocationBottomSheet,
              ),
            ),
          );
        },
      ),
    );
  }
}
