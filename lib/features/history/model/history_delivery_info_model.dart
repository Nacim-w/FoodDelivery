class DeliveryInfo {
  final String deliveryPersonId;
  final String deliveryPersonName;
  final String contactNumber;
  final String? vehicleInfo;
  final String estimatedArrivalTime;
  final DateTime acceptedAt;
  final DateTime? etaDeadline;
  final int etaMinutes;

  DeliveryInfo({
    required this.deliveryPersonId,
    required this.deliveryPersonName,
    required this.contactNumber,
    this.vehicleInfo,
    required this.estimatedArrivalTime,
    required this.acceptedAt,
    this.etaDeadline,
    required this.etaMinutes,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      deliveryPersonId: json['deliveryPersonId'] ?? '',
      deliveryPersonName: json['deliveryPersonName'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      vehicleInfo: json['vehicleInfo'],
      estimatedArrivalTime: json['estimatedArrivalTime'] ?? '',
      acceptedAt: DateTime.tryParse(json['acceptedAt'] ?? '') ?? DateTime(1970),
      etaDeadline: json['etaDeadline'] != null
          ? DateTime.tryParse(json['etaDeadline'])
          : null,
      etaMinutes: json['etaMinutes'] ?? 0,
    );
  }
}
