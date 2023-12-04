import 'package:cloud_firestore/cloud_firestore.dart';
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

class Message{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  Message( {required this.senderId,required this.senderEmail, required this.receiverId,required this.message,required this.timestamp,});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

}