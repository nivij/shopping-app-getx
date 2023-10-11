import 'package:get/get.dart';

import '../models/model.dart';
import '../models/product_model.dart';

class DetailsController extends GetxController {
  final detailsList = <Product>[
    Product(
      photo: "assets/model/model8.png",
      name: "SAIOM", price: "100",
      id: "0",
      qty: 0,
      CategoryId: "Dresses",
    ),
    Product(

      photo: "assets/model/model6.png",
      name: "t-shirt",
      price: "100",
      id: "1",
      qty: 0,
      CategoryId: 'Dresses',
    ),
    Product(
      photo: "assets/model/model5.png",
      name: "casual shirt",
      price: "100",
      id: "2",
      qty: 0,
      CategoryId: 'Dresses',
    ),
    Product(
      photo: "assets/model/model7.png",
      name: "print shirt",
      price: "100",
      id: "3",
      qty: 0,
      CategoryId: 'Dresses',
    ),

    Product(
      photo: "assets/model/panther9.png",
      name: "print shirt",
      price: "100",
      id: "4",
      qty: 0,
      CategoryId: 'Jackets',
    ),
    Product(
      photo: "assets/model/stranger10.png",
      name: "print shirt",
      price: "100",
      id: "5",
      qty: 0,
      CategoryId: 'Jackets',
    ),
    Product(
      photo: "assets/model/gangsta11.png",
      name: "print shirt",
      price: "100",
      id: "6",
      qty: 0,
      CategoryId: 'Jackets',
    ),
    Product(
      photo: "assets/model/batman12.png",
      name: "print shirt",
      price: "100",
      id: "7",
      qty: 0,
      CategoryId: 'Jackets',
    ),
  ];
  // Get a list of products by id
  List<Product> getProductsById(String CategoryId) {
    return detailsList.where((product) => product.CategoryId == CategoryId).toList();
  }

}
