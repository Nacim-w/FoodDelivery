import 'package:legy/features/order_details/model/details_supplements.dart';

class DetailsOrderItem {
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double promotionAmount;
  final List<DetailsSupplementModel> supplements;

  DetailsOrderItem({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.promotionAmount,
    required this.supplements,
  });

  factory DetailsOrderItem.fromJson(Map<String, dynamic> json) {
    return DetailsOrderItem(
      productId: json['productId'],
      productName: json['productName'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'],
      promotionAmount: (json['promotionAmount'] as num).toDouble(),
      supplements: (json['supplements'] as List<dynamic>)
          .map((s) => DetailsSupplementModel.fromJson(s))
          .toList(),
    );
  }
}
