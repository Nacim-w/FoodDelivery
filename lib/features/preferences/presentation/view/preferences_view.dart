import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class PreferencesView extends StatefulWidget {
  static const routePath = "food-preferences";
  const PreferencesView({super.key});

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _preferences = const [
    {'label': 'Tacos', 'icon': 'assets/icons/pref1.svg'},
    {'label': 'Pizza', 'icon': 'assets/icons/pref2.svg'},
    {'label': 'Burgers', 'icon': 'assets/icons/pref3.svg'},
    {'label': 'Desserts', 'icon': 'assets/icons/pref4.svg'},
    {'label': 'Beauty & Style', 'icon': 'assets/icons/pref5.svg'},
    {'label': 'Japonais', 'icon': 'assets/icons/pref6.svg'},
    {'label': 'Végétarien', 'icon': 'assets/icons/pref7.svg'},
    {'label': 'Poulet', 'icon': 'assets/icons/pref8.svg'},
    {'label': 'Petit-déjeuner', 'icon': 'assets/icons/pref9.svg'},
    {'label': 'Chocolat', 'icon': 'assets/icons/pref10.svg'},
    {'label': 'Confiseries', 'icon': 'assets/icons/pref11.svg'},
    {'label': 'Boissons', 'icon': 'assets/icons/pref12.svg'},
    {'label': 'Pâtisseries', 'icon': 'assets/icons/pref13.svg'},
  ];

  final Set<int> _selectedIndexes = {};
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onSelect(int index) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else if (_selectedIndexes.length < 5) {
        _selectedIndexes.add(index);
      } else {
        _triggerShake();
      }
    });
  }

  void _triggerShake() {
    _shakeController.forward(from: 0).then((_) => _shakeController.reverse());
  }

  Future<void> _onPass() async {
    if (_selectedIndexes.isNotEmpty) {
      await sl<CacheHelper>().cacheFirstTimer();
      context.go(HomePage.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vos préférences culinaires ?',
              style: TextStyles.titleBoldLarge.black1),
          const Text(
            'Des idées repas selon vos goûts',
            style: TextStyles.titleRegularSmallest,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                final offset = _shakeAnimation.value;
                return Transform.translate(
                  offset: Offset(offset % 2 == 0 ? offset : -offset, 0),
                  child: child,
                );
              },
              child: GridView.builder(
                itemCount: _preferences.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final pref = _preferences[index];
                  final isSelected = _selectedIndexes.contains(index);

                  return GestureDetector(
                    onTap: () => _onSelect(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.orange.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(20),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color:
                              isSelected ? Colors.orange : Colors.grey.shade200,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            pref['icon']!,
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              pref['label']!,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.go(HomePage.routePath),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.lightThemeGrey2,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Ignorer',
                    style: TextStyles.textMediumLarge.black1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _selectedIndexes.isEmpty ? null : _onPass,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        Colours.lightThemeOrange0.withAlpha(120),
                    disabledForegroundColor: Colours.lightThemeWhite1,
                  ),
                  child: const Text('Passer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
