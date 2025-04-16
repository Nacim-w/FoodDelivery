import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:legy/common/res/media.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:legy/pages/home/widgets/caroussal_items.dart';

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
              image: Media.homeBanner1,
              title: "Spécial crêpes",
              body: "PROFITEZ DE LA DÉLICIEUSE CRÊPE",
              description: "60% de réduction",
            ),
            CaroussalItems(
              image: Media.homeBanner2,
              title: "Spécial crêpes",
              body: "PROFITEZ DE LA DÉLICIEUSE CRÊPE",
              description: "60% de réduction",
            ),
            CaroussalItems(
              image: Media.homeBanner1,
              title: "Spécial crêpes",
              body: "PROFITEZ DE LA DÉLICIEUSE CRÊPE",
              description: "60% de réduction",
            ),
          ],
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.17,
            initialPage: _currentPage,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index; // Update current page
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
