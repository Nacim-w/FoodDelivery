class LocationUpdateModel {
  final String orderId;
  final String livreurId;
  final double latitude;
  final double longitude;
  final int timestamp;

  LocationUpdateModel({
    required this.orderId,
    required this.livreurId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory LocationUpdateModel.fromJson(Map<String, dynamic> json) {
    return LocationUpdateModel(
      orderId: json['orderId'],
      livreurId: json['livreurId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'livreurId': livreurId,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
      };
}
