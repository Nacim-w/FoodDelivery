class ProductModel {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final String categoryId;
  final List<Supplement> supplements;
  final List<dynamic>? ingredients;
  final String imageUrl;
  final double pricePreCom;
  int quantity;

  ProductModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.supplements,
    this.ingredients,
    required this.imageUrl,
    required this.pricePreCom,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      restaurantId: json['restaurantId'],
      name: json['name'],
      description: json['description'],
      categoryId: json['categoryId'],
      supplements: (json['supplements'] as List)
          .map((item) => Supplement.fromJson(item))
          .toList(),
      ingredients: json['ingredients'],
      imageUrl: json['imageUrl'],
      pricePreCom: json['pricePreCom'] != null
          ? double.parse(json['pricePreCom'].toString())
          : 0.0,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'supplements': supplements.map((s) => s.toJson()).toList(),
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'pricePreCom': pricePreCom,
      'quantity': quantity,
    };
  }

  ProductModel copyWith({
    String? id,
    String? restaurantId,
    String? name,
    String? description,
    String? categoryId,
    List<Supplement>? supplements,
    List<dynamic>? ingredients,
    String? imageUrl,
    double? pricePreCom,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      supplements: supplements ?? this.supplements,
      ingredients: ingredients ?? this.ingredients,
      imageUrl: imageUrl ?? this.imageUrl,
      pricePreCom: pricePreCom ?? this.pricePreCom,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Supplement {
  final String id;
  final String name;
  final String description;
  final num price;
  int? quantity;
  final dynamic createdby;

  Supplement({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.quantity,
    this.createdby,
  });

  factory Supplement.fromJson(Map<String, dynamic> json) {
    return Supplement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      createdby: json['createdby'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'createdby': createdby,
    };
  }

  Supplement copyWith({
    String? id,
    String? name,
    String? description,
    num? price,
    int? quantity,
    dynamic createdby,
  }) {
    return Supplement(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      createdby: createdby ?? this.createdby,
    );
  }
}
