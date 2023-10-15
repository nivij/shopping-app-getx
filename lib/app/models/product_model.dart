class Product {
  final String id;
  final String CategoryId;
  final String description;
  final String name;
  final String price;
  final String photo;
  late int qty;
  Product( {
    required this.CategoryId,
    required this.description,
    required this.id,
    required this.name,
    required this.price,
    required this.photo
    ,required this.qty
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      CategoryId: json['CategoryId'].toString(),
      id: json['id'].toString(),
      name: json['name'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
      qty: int.tryParse(json['qty'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CategoryId': CategoryId,
      'name': name,
      'price': price,
      'photo': photo,
      "qty": qty,
      "description": description,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && this.id == other.id;
  }

  // @override
  // String get hashCode {
  //   return id;
  // }
}




