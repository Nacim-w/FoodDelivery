import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';

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

  ImageProvider _getImageProvider(String image) {
    if (image.isEmpty) {
      return const AssetImage(Media.restaurant1);
    } else if (image.startsWith('http')) {
      return NetworkImage(image);
    } else if (image.startsWith('data:image')) {
      try {
        final base64Str = image.split(',').last;
        final imageBytes = base64Decode(base64Str);
        return MemoryImage(imageBytes);
      } catch (_) {
        return const AssetImage(Media.restaurant1);
      }
    } else {
      return const AssetImage(Media.restaurant1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colours.lightThemeGreen5,
      dashPattern: const [6, 6],
      strokeWidth: 1.5,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: _getImageProvider(order.restaurant.logo),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.restaurant.name,
                        style: TextStyles.textBoldLarge),
                    Text("Commande n° ${order.orderId}",
                        style: TextStyles.textRegularSmallest),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          if (order.items.isNotEmpty) _buildOrderItem(order),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(Media.homeClock, width: 16),
                  const Gap(4),
                  Text("Passée", style: TextStyles.textMediumSmall.orange0),
                  const Gap(16),
                  SvgPicture.asset(
                    Media.ratingStar,
                    width: 16,
                    colorFilter: const ColorFilter.mode(
                      Colours.lightThemeYellow0,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(4),
                  Text('${order.total.toStringAsFixed(2)} CFA',
                      style: TextStyles.textMediumSmall.green5),
                ],
              ),
              TextButton(
                onPressed: () => _showReportBottomSheet(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("Signaler",
                    style: TextStyles.textRegularSmallest.orange5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderModel order) {
    final item = order.items.first;
    final totalSupplements =
        item.supplements.fold(0.0, (sum, _) => sum); // Add logic if needed
    final total = item.unitPrice * item.quantity + totalSupplements;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colours.lightThemeGreen2.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.productName, style: TextStyles.textMediumSmall.black1),
          const Gap(8),
          Text('${total.toStringAsFixed(2)} CFA',
              style: TextStyles.textSemiBoldLarge.green5),
          const Gap(8),
          Divider(
            color: Colours.lightThemeBlack1.withAlpha(50),
            thickness: 0.5,
          ),
          Row(
            children: [
              Text('Quantité: ${item.quantity}',
                  style: TextStyles.textMediumSmall.black1),
              const SizedBox(width: 16),
              Text('Prix unitaire: ${item.unitPrice.toStringAsFixed(2)}',
                  style: TextStyles.textMediumSmall.black1),
            ],
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
