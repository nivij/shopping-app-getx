class Product {
  final String id;
  final String CategoryId;
  final String description;
  final String name;
  final String price;
  final List<String> photos; // Change the data type to List<String>
  late int qty;

  Product({
    required this.CategoryId,
    required this.description,
    required this.id,
    required this.name,
    required this.price,
    required this.photos, // Change the property name to photos
    required this.qty,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      CategoryId: json['CategoryId'].toString(),
      id: json['id'].toString(),
      name: json['name'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
      photos: (json['photos'] as List<dynamic>).cast<String>(), // Change to List<String>
      qty: int.tryParse(json['qty'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CategoryId': CategoryId,
      'name': name,
      'price': price,
      'photos': photos, // Change the property name to photos
      'qty': qty,
      'description': description,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && this.id == other.id;
  }
}
