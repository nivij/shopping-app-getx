class Product {
  final String id; // Add 'id' parameter
  final String CategoryId; // Add 'id' parameter

  final String name;
  final String price;
  final String photo;
  late int qty;
  Product( {
    required this.CategoryId,
    required this.id, // Include 'id' parameter in the constructor
    required this.name,
    required this.price,
    required this.photo
    ,required this.qty
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      CategoryId: json['id'].toString() , // Convert to int or use 0 as a default value
      id: json['id'].toString() , // Convert to int or use 0 as a default value
      name: json['name'] as String,
      price: json['price'] as String,
      photo: json['photo'] as String,
      qty: int.tryParse(json['qty'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,             // Include 'id' field in the JSON representation
      'CategoryId': CategoryId,             // Include 'id' field in the JSON representation
      'name': name,
      'price': price,
      'photo': photo,
      "qty": qty,
    };
  }

  @override // Specify the type for 'other' in the == operator
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && this.id == other.id;
  }

  // @override
  // String get hashCode {
  //   return id;
  // }
}




class Jackets {
  final int id; // Add 'id' parameter
  final String name;
  final String price;
  final String photo;
  late int qty;
  Jackets({
    required this.id, // Include 'id' parameter in the constructor
    required this.name,
    required this.price,
    required this.photo
    ,required this.qty
  });

}

