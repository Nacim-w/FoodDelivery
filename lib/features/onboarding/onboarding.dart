import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": Media.onboarding1,
      "title": "Commandez rapidement",
      "subtitle": "Commandez votre repas",
      "desc":
          "Un bon plat peut illuminer votre journée. Commandez maintenant pour satisfaire toutes vos envies gourmandes."
    },
    {
      "image": Media.onboarding2,
      "title": "Paiement facile",
      "subtitle": "Paiement en ligne sécurisé",
      "desc":
          "Vos informations de paiement sont cryptées pour garantir votre sécurité."
    },
    {
      "image": Media.onboarding3,
      "title": "Livraison rapide",
      "subtitle": "Livraison à domicile",
      "desc":
          "Nous assurons un service porte-à-porte rapide, tout en garantissant la meilleure qualité de repas."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (_, index) {
                final data = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Image.asset(data['image']!, height: 300),
                      const SizedBox(height: 30),
                      Text(data['title']!,
                          style: TextStyles.textSemiBoldLargest.orange0),
                      const SizedBox(height: 10),
                      Text(
                        data['subtitle']!,
                        style: TextStyles.titleBold.black1,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data['desc']!,
                        textAlign: TextAlign.center,
                        style: TextStyles.textRegular.grey0,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildPageIndicator(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DotsIndicator(
        dotsCount: onboardingData.length,
        position: _currentPage.toDouble(),
        decorator: DotsDecorator(
          activeColor: Colors.orange,
          size: const Size.square(8.0),
          activeSize: const Size(18.0, 8.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            child: Text(
              'Retour',
              style: TextStyles.textMediumSmall.black1,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              if (_currentPage < onboardingData.length - 1) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                context.go(HomePage.routePath);
              }
            },
            child: Row(
              children: [
                Text(
                  'Suivant',
                  style: TextStyles.textMediumLarge.white1,
                ),
                Gap(10),
                Icon(Icons.arrow_forward_ios,
                    color: Colours.lightThemeWhite1, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
