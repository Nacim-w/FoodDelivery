import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class DetailsLocation extends StatefulWidget {
  const DetailsLocation({
    super.key,
    required this.from,
    required this.to,
    required this.onLocationSelected,
  });

  final String from;
  final String to;
  final Function(String) onLocationSelected;

  @override
  State<DetailsLocation> createState() => _DetailsLocationWidgetState();
}

class _DetailsLocationWidgetState extends State<DetailsLocation> {
  late CacheHelper _cacheHelper;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initCache();
  }

  Future<void> _initCache() async {
    final prefs = await SharedPreferences.getInstance();
    _cacheHelper = CacheHelper(prefs);
    setState(() {
      _initialized = true;
    });
  }

  void _showLocationBottomSheet() async {
    if (!_initialized) return;

    final savedLocations = _cacheHelper.getSavedLocations();
    List<SavedLocation> locations = List.from(savedLocations);

    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colours.lightThemeWhite1,
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
                      Text(
                        'Aucun emplacement enregistré',
                        style: TextStyles.textBoldLarge.black1,
                      ),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
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
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                      widget.onLocationSelected(location.name);
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: const Color.fromARGB(150, 126, 126, 126)),
          borderRadius: BorderRadius.circular(20),
        ),
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
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colours.lightThemeGrey1),
        onTap: _showLocationBottomSheet,
      ),
    );
  }
}
