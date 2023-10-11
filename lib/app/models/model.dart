import 'package:gocart/app/models/product_model.dart';

class Textt{

  String textt;

  Textt({required this.textt,});
}


class Colorr{

 var colorr;

  Colorr({required this.colorr,});
}
class WishlistItem {
  final Product product;

  WishlistItem(this.product);

  // Define a factory method to create a WishlistItem from a JSON object
  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(Product.fromJson(json['product'])); // Adjust this based on your actual JSON structure
  }

  // Define a method to convert WishlistItem to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), // Adjust this based on your actual JSON structure
    };
  }
}


class ItemSize{
  String size;
  ItemSize({required this.size,});
}
