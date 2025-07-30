import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/preferences/presentation/widgets/preference_buttons.dart';
import 'package:legy/features/preferences/presentation/widgets/preference_grid.dart';
import 'package:legy/features/preferences/presentation/widgets/preference_header.dart';

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
          context.adaptiveGap,
          const PreferencesHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: PreferencesGrid(
              preferences: _preferences,
              selectedIndexes: _selectedIndexes,
              onSelect: _onSelect,
              shakeAnimation: _shakeAnimation,
            ),
          ),
          const SizedBox(height: 16),
          PreferencesButtons(
            canProceed: _selectedIndexes.isNotEmpty,
            onPass: _onPass,
          ),
        ],
      ),
    );
  }
}
