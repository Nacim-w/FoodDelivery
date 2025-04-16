import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/res/media.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Media.sidebar,
            width: 16,
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Media.notificationBell,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              Gap(10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Media.cart,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
