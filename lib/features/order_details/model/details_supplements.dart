class DetailsSupplementModel {
  final String supplementId;
  final int quantity;

  DetailsSupplementModel({
    required this.supplementId,
    required this.quantity,
  });

  factory DetailsSupplementModel.fromJson(Map<String, dynamic> json) {
    return DetailsSupplementModel(
      supplementId: json['supplementId'],
      quantity: json['quantity'],
    );
  }
}
