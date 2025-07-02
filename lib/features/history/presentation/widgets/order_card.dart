import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/history/model/history_order_models.dart';
import 'package:legy/features/history/presentation/app/history_cubit.dart';
import 'package:legy/features/history/presentation/widgets/bottom_sheet.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final base64Str = order.restaurant.logo.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);

    return Container(
      height: context.width * 0.26,
      width: context.width * 0.95,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite4,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack1.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: context.width * 0.26,
                width: context.width * 0.23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(8),
                    Text(order.restaurant.name,
                        style: TextStyles.textBoldSmall.brown5,
                        overflow: TextOverflow.ellipsis),
                    const Gap(2),
                    Text(
                      order.items.isNotEmpty
                          ? order.items[0].productName
                          : 'Commande',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textSemiBoldSmall.grey5,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(Media.homeClock),
                        const Gap(4),
                        Text("Passée",
                            style: TextStyles.textMediumSmall.orange0),
                        const Gap(20),
                        SvgPicture.asset(Media.ratingStar,
                            colorFilter: const ColorFilter.mode(
                                Colours.lightThemeYellow0, BlendMode.srcIn)),
                        const Gap(4),
                        Text('${order.total.toStringAsFixed(2)} CFA',
                            style: TextStyles.textMediumSmall.orange0),
                      ],
                    ),
                    const Gap(4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => _showReportBottomSheet(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Signaler",
                          style: TextStyles.textRegularSmallest.orange5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: Colours.lightThemeOrange0,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(Media.homeCamera),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportBottomSheet(BuildContext context) {
    final historyCubit = context.read<HistoryCubit>();

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => BlocProvider.value(
        value: historyCubit,
        child: ReportBottomSheet(orderId: order.orderId),
      ),
    );
  }
}
