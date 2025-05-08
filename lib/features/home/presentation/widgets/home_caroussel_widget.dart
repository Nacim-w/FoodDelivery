import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:legy/features/home/presentation/widgets/caroussal_items.dart';

class HomeCaroussal extends StatefulWidget {
  const HomeCaroussal({super.key});

  @override
  State<HomeCaroussal> createState() => _HomeCaroussalState();
}

class _HomeCaroussalState extends State<HomeCaroussal> {
  int _currentPage = 0;
  final int pageLength = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            CaroussalItems(
              image: Media.homeBurger,
              title: "BURGER SPÉCIAL",
              body: "OBTENEZ VOTRE BURGER PRÉFÉRÉ !",
              buttonName: "Créez votre burger",
            ),
            CaroussalItems(
              image: Media.homeBurger,
              title: "BURGER SPÉCIAL",
              body: "OBTENEZ VOTRE BURGER PRÉFÉRÉ !",
              buttonName: "Créez votre burger",
            ),
            CaroussalItems(
              image: Media.homeBurger,
              title: "BURGER SPÉCIAL",
              body: "OBTENEZ VOTRE BURGER PRÉFÉRÉ !",
              buttonName: "Créez votre burger",
            ),
          ],
          options: CarouselOptions(
            viewportFraction: 1.0,
            height: context.height * 0.20,
            initialPage: _currentPage,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        DotsIndicator(
          dotsCount: pageLength,
          position: _currentPage.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(32.0, 9.0),
            activeColor: const Color.fromARGB(255, 223, 191, 29),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }
}
