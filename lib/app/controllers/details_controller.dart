import 'package:get/get.dart';

import '../models/model.dart';
import '../models/product_model.dart';

class DetailsController extends GetxController {
  final detailsList = <Product>[
    Product(
      photo: "assets/model/model8.png",
      name: "SAIOM",
      price: "1,199",
      id: "0",
      qty: 0,
      CategoryId: "Dresses",
      description: 'Cross String Work on Neck Solid Top',
    ),
    Product(
      photo: "assets/model/model6.png",
      name: "Oversized Punk Shirt",
      price: "449",
      id: "1",
      qty: 0,
      CategoryId: 'Dresses',
      description: 'soft, comfortable 100% cotton fabric',
    ),
    Product(
      photo: "assets/model/model5.png",
      name: "Toplot T-Shirt",
      price: "329",
      id: "2",
      qty: 0,
      CategoryId: 'Dresses',
      description: 'Casual Printed with Short Sleeve (Mens-T-Shirt-5097)',
    ),
    Product(
      photo: "assets/model/model7.png",
      name: "Veirdo Oversized shirt",
      price: "529",
      id: "3",
      qty: 0,
      CategoryId: 'Dresses',
      description: 'Oversized Cotton Graphic Print Purple Crew Neck T-Shirt',
    ),
    Product(
      photo: "assets/model/panther9.png",
      name: "Black Panther",
      price: "1455",
      id: "4",
      qty: 0,
      CategoryId: 'Jackets',
      description: 'The Suit Cotton Men Hoodie ',
    ),
    Product(
      photo: "assets/model/stranger10.png",
      name: "Stranger Things",
      price: "2499",
      id: "5",
      qty: 0,
      CategoryId: 'Jackets',
      description: '60% Cotton 40% Polyester',
    ),
    Product(
      photo: "assets/model/gangsta11.png",
      name: "Gangsta Jacket",
      price: "2599",
      id: "6",
      qty: 0,
      CategoryId: 'Jackets',
      description: '100% Polyester',
    ),
    Product(
      photo: "assets/model/batman12.png",
      name: "Batman",
      price: "2127",
      id: "7",
      qty: 0,
      CategoryId: 'Jackets',
      description: 'Classic Logo Black Printed Puffer Jackets',
    ),
    Product(
      photo: "assets/model/jeans1.png",
      name: "Highlander Men Grey",
      price: "811",
      id: "8",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'Men Tapered Fit Mid Rise Grey Jeans',
    ),
    Product(
      photo: "assets/model/jeans2.png",
      name: "Highlander Navy Blue",
      price: "649",
      id: "9",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'KETCH Men Jeans',
    ),
    Product(
      photo: "assets/model/jeans3.png",
      name: "Highlander Light Grey",
      price: "706",
      id: "10",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'Men Grey Tapered Fit Mid-Rise Clean Look Stretchable Jeans',
    ),
    Product(
      photo: "assets/model/jeans4.png",
      name: "Highlander Men",
      price: "1680",
      id: "11",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'Men Tapered Fit Mid Rise Dark Grey Jeans',
    ),
    Product(
      photo: "assets/model/shoes1.png",
      name: "RedTape Sneaker",
      price: "499",
      id: "12",
      qty: 0,
      CategoryId: 'Shoes',
      description: 'Enhanced Comfort with Cushioned Insole and Slip-Resistant',
    ),
    Product(
      photo: "assets/model/shoes2.png",
      name: "RedTape Sneaker",
      price: "499",
      id: "13",
      qty: 0,
      CategoryId: 'Shoes',
      description:
          'Soft Cushioned Insole, Slip-Resistance, Dynamic Feet Support, Arch Support ',
    ),
    Product(
      photo: "assets/model/shoes3.png",
      name: "RedTape Sneaker",
      price: "1679",
      id: "14",
      qty: 0,
      CategoryId: 'Shoes',
      description: 'Elevated Comfort, Perfect Casual Shoes for Men',
    ),
    Product(
      photo: "assets/model/shoes4.png",
      name: "RedTape Sneaker",
      price: "1449",
      id: "15",
      qty: 0,
      CategoryId: 'Shoes',
      description:
          'Elevated Comfort, Perfect Casual Shoes for Men ',
    ),
  ];
  // Get a list of products by id
  List<Product> getProductsById(String CategoryId) {
    return detailsList
        .where((product) => product.CategoryId == CategoryId)
        .toList();
  }

  final searchResults = <Product>[].obs;

  // Function to filter products based on search query
  void searchProducts(String query) {
    query = query.trim();
    searchResults.value = detailsList
        .where((product) =>
    product.name.trim().toLowerCase().contains(query) ||
        product.description.trim().toLowerCase().contains(query))
        .toList();
    if (searchResults.isNotEmpty) {
      addRecentSearch(searchResults[0]); // Add the first result to recent searches
    }
  }



  // Function to clear the search results
  void clearSearchResults() {
    searchResults.clear();
  }
  final recentSearches = <Product>[].obs;

  // Function to add a recently searched product
  void addRecentSearch(Product product) {
    if (!recentSearches.contains(product)) {
      recentSearches.insert(0, product);
    }
  }
  List<Product> filterProductsByPriceRange(String CategoryId, double minPrice, double maxPrice) {
    return detailsList
        .where((product) =>
    product.CategoryId == CategoryId &&
        int.parse(product.price) >= minPrice &&
        int.parse(product.price) <= maxPrice)
        .toList();
  }

}
