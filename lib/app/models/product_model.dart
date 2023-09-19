class Modelphoto {
  final int id; // Add 'id' parameter
  final String name;
  final String price;
  final String photo;
  // late int qty;
  Modelphoto({
    required this.id, // Include 'id' parameter in the constructor
    required this.name,
    required this.price,
    required this.photo
    // ,required this.qty
  });

  factory Modelphoto.fromJson(Map<String, dynamic> json) {
    return Modelphoto(
      id: int.tryParse(json['id'].toString()) ?? 0, // Convert to int or use 0 as a default value
      name: json['name'] as String,
      price: json['price'] as String,
      photo: json['photo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,             // Include 'id' field in the JSON representation
      'name': name,
      'price': price,
      'photo': photo,
      // "qty": qty,
    };
  }

  @override // Specify the type for 'other' in the == operator
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Modelphoto && this.id == other.id;
  }

  @override
  int get hashCode {
    return id;
  }
}

