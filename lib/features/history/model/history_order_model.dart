class HistoryOrderModel {
  final String id;
  final String token;

  HistoryOrderModel({
    required this.id,
    required this.token,
  });

  factory HistoryOrderModel.empty() {
    return HistoryOrderModel(
      id: '',
      token: '',
    );
  }

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) {
    return HistoryOrderModel(
      id: json['id'],
      token: json['token'],
    );
  }

  HistoryOrderModel copyWith({
    String? id,
    String? email,
    String? token,
  }) {
    return HistoryOrderModel(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
