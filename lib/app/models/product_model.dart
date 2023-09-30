class Dresses {
  final int id; // Add 'id' parameter
  final String name;
  final String price;
  final String photo;
  late int qty;
  Dresses({
    required this.id, // Include 'id' parameter in the constructor
    required this.name,
    required this.price,
    required this.photo
    ,required this.qty
  });

  factory Dresses.fromJson(Map<String, dynamic> json) {
    return Dresses(
      id: int.tryParse(json['id'].toString()) ?? 0, // Convert to int or use 0 as a default value
      name: json['name'] as String,
      price: json['price'] as String,
      photo: json['photo'] as String,
      qty: int.tryParse(json['qty'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,             // Include 'id' field in the JSON representation
      'name': name,
      'price': price,
      'photo': photo,
      "qty": qty,
    };
  }

  @override // Specify the type for 'other' in the == operator
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Dresses && this.id == other.id;
  }

  @override
  int get hashCode {
    return id;
  }
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

