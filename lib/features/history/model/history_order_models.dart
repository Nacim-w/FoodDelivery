class OrderModel {
  final String id;
  final List<ItemModel> items;
  final double total;
  final ClientModel client;
  final RestaurantModel restaurant;
  final String? deliveryInfo;
  final String deliveryAddress;
  final String livreurStatus;
  final String deliveryMode;
  final String paymentStatus;
  final String paymentMethod;
  final String orderStatus;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.client,
    required this.restaurant,
    this.deliveryInfo,
    required this.deliveryAddress,
    required this.livreurStatus,
    required this.deliveryMode,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderStatus,
  });

  factory OrderModel.empty() {
    return OrderModel(
      id: '',
      items: [],
      total: 0.0,
      client: ClientModel.empty(),
      restaurant: RestaurantModel.empty(),
      deliveryInfo: null,
      deliveryAddress: '',
      livreurStatus: '',
      deliveryMode: '',
      paymentStatus: '',
      paymentMethod: '',
      orderStatus: '',
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      items: (json['items'] as List)
          .map((item) => ItemModel.fromJson(item))
          .toList(),
      total: (json['total'] as num).toDouble(),
      client: ClientModel.fromJson(json['client']),
      restaurant: RestaurantModel.fromJson(json['restaurant']),
      deliveryInfo: json['deliveryInfo'],
      deliveryAddress: json['deliveryAddress'],
      livreurStatus: json['livreurStatus'],
      deliveryMode: json['deliveryMode'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'],
      orderStatus: json['orderStatus'],
    );
  }

  OrderModel copyWith({
    String? id,
    List<ItemModel>? items,
    double? total,
    ClientModel? client,
    RestaurantModel? restaurant,
    String? deliveryInfo,
    String? deliveryAddress,
    String? livreurStatus,
    String? deliveryMode,
    String? paymentStatus,
    String? paymentMethod,
    String? orderStatus,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      client: client ?? this.client,
      restaurant: restaurant ?? this.restaurant,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      livreurStatus: livreurStatus ?? this.livreurStatus,
      deliveryMode: deliveryMode ?? this.deliveryMode,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}

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
    return ItemModel(
      productId: json['productId'],
      productName: json['productName'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'],
      categoryId: json['categoryId'],
      promotionAmount: (json['promotionAmount'] as num).toDouble(),
      supplements: (json['supplements'] as List)
          .map((x) => SupplementModel.fromJson(x))
          .toList(),
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

class SupplementModel {
  final String supplementId;
  final int quantity;

  SupplementModel({
    required this.supplementId,
    required this.quantity,
  });

  factory SupplementModel.empty() {
    return SupplementModel(
      supplementId: '',
      quantity: 0,
    );
  }

  factory SupplementModel.fromJson(Map<String, dynamic> json) {
    return SupplementModel(
      supplementId: json['supplementId'],
      quantity: json['quantity'],
    );
  }

  SupplementModel copyWith({
    String? supplementId,
    int? quantity,
  }) {
    return SupplementModel(
      supplementId: supplementId ?? this.supplementId,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ClientModel {
  final String clientId;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final double? longitude;
  final double? latitude;

  ClientModel({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    this.longitude,
    this.latitude,
  });

  factory ClientModel.empty() {
    return ClientModel(
      clientId: '',
      firstName: '',
      lastName: '',
      phone: '',
      address: '',
      longitude: null,
      latitude: null,
    );
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clientId: json['clientId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      address: json['address'],
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );
  }

  ClientModel copyWith({
    String? clientId,
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    double? longitude,
    double? latitude,
  }) {
    return ClientModel(
      clientId: clientId ?? this.clientId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}

class RestaurantModel {
  final String restaurantId;
  final String name;
  final String phone;
  final String address;
  final double commission;
  final double latitude;
  final double longitude;
  final String logo;

  RestaurantModel({
    required this.restaurantId,
    required this.name,
    required this.phone,
    required this.address,
    required this.commission,
    required this.latitude,
    required this.longitude,
    required this.logo,
  });

  factory RestaurantModel.empty() {
    return RestaurantModel(
      restaurantId: '',
      name: '',
      phone: '',
      address: '',
      commission: 0.0,
      latitude: 0.0,
      longitude: 0.0,
      logo: '',
    );
  }

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
        restaurantId: json['restaurantId'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        commission: (json['commission'] as num).toDouble(),
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        logo: json['logo']);
  }

  RestaurantModel copyWith({
    String? restaurantId,
    String? name,
    String? phone,
    String? address,
    double? commission,
    double? latitude,
    double? longitude,
    String? logo,
  }) {
    return RestaurantModel(
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      commission: commission ?? this.commission,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      logo: logo ?? this.logo,
    );
  }
}
