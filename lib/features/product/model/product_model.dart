class ProductModel {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final String categoryId;
  final List<Supplement> supplements;
  final List<dynamic>? ingredients;
  final String imageUrl;
  final double pricePostCom;

  ProductModel(
      {required this.id,
      required this.restaurantId,
      required this.name,
      required this.description,
      required this.categoryId,
      required this.supplements,
      this.ingredients,
      required this.imageUrl,
      required this.pricePostCom});

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
      pricePostCom: json['pricePostCom'] != null
          ? double.parse(json['pricePostCom'].toString())
          : 0.0,
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
      'pricePostCom': pricePostCom,
    };
  }
}

class Supplement {
  final String id;
  final String name;
  final String description;
  final num price;
  final dynamic createdby;

  Supplement({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.createdby,
  });

  factory Supplement.fromJson(Map<String, dynamic> json) {
    return Supplement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      createdby: json['createdby'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'createdby': createdby,
    };
  }
}
