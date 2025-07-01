import 'package:legy/features/history/model/supplement_model.dart';

class ItemModel {
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final String categoryId;
  final double promotionAmount;
  final List<SupplementModel> supplements;

  ItemModel({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.categoryId,
    required this.promotionAmount,
    required this.supplements,
  });

  factory ItemModel.empty() {
    return ItemModel(
      productId: '',
      productName: '',
      unitPrice: 0.0,
      quantity: 0,
      categoryId: '',
      promotionAmount: 0.0,
      supplements: [],
    );
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final rawSupplements = json['supplements'];
    List<SupplementModel> parsedSupplements = [];
    if (rawSupplements != null && rawSupplements is List) {
      parsedSupplements = rawSupplements
          .where((e) => e != null)
          .map((e) => SupplementModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return ItemModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      categoryId: json['categoryId'] ?? '',
      promotionAmount: (json['promotionAmount'] as num?)?.toDouble() ?? 0.0,
      supplements: parsedSupplements,
    );
  }

  ItemModel copyWith({
    String? productId,
    String? productName,
    double? unitPrice,
    int? quantity,
    String? categoryId,
    double? promotionAmount,
    List<SupplementModel>? supplements,
  }) {
    return ItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      promotionAmount: promotionAmount ?? this.promotionAmount,
      supplements: supplements ?? this.supplements,
    );
  }
}
