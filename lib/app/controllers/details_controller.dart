import 'package:get/get.dart';

import '../models/model.dart';
import '../models/product_model.dart';

class DetailsController extends GetxController {
  final detailsList = <Dresses>[
    Dresses(
      photo: "assets/model/model8.png",
      name: "SAIOM", price: "100",
      id: 0,
      qty: 0,
    ),
    Dresses(

      photo: "assets/model/model6.png",
      name: "t-shirt",
      price: "100",
      id: 1,
      qty: 0,
    ),
    Dresses(
      photo: "assets/model/model5.png",
      name: "casual shirt",
      price: "100",
      id: 2,
      qty: 0,
    ),
    Dresses(
      photo: "assets/model/model7.png",
      name: "print shirt",
      price: "100",
      id: 3,
      qty: 0,
    ),
  ];
}