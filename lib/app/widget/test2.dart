// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../controllers/details_controller.dart';
//
// class ProductListByCategory extends StatelessWidget {
//   final String categoryId;
//   final DetailsController controller;
//
//   ProductListByCategory({required this.categoryId, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final products = controller.getProductsById(categoryId);
//
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return ListTile(
//           leading: Image.asset(product.photo),
//           title: Text(product.name),
//           subtitle: Text("Price: \$${product.price}"),
//           // Add more details or actions here if needed
//         );
//       },
//     );
//   }
// }
